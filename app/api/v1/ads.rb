module V1
  class Ads < Base

    resource :ads do
      desc 'Retreive all ads or search by query'
      params do
        use :requires_coordinates, :optional_geo_range, :optional_pagination
      end
      get do
        query         = params[:query].present? ? params[:query] : nil
        page_nr       = Pagination.page_nr(params[:page])
        search_params = Search.build_query(query: query,
                          lat: params[:lat], lon: params[:lon],
                          from: params[:from], to: params[:to])

        ads          = Ad.search(search_params).page(page_nr).records
        newest_first = ads.sort_by{ |rec| rec[:created_at] }.reverse
        present :ads, newest_first, with: V1::Entities::Ads
      end

      desc 'Get the newest 25 ads regardless of location'
      get 'recent' do
        cache key: "api-v1-ads-recent", expires_in: 10.minutes do
          ads = Ad.latest.limit(25)
          present :ads, ads, with: V1::Entities::Ads
        end
      end

      desc 'Lookup of single ad'
      params { use :requires_ad_id }
      route_param :id do
        get do
          ad = Ad.find(params[:id])
          present :ad, ad, with: V1::Entities::Ads
        end
      end

      desc 'Update existing ad, applies only to the signed in user\'s ads'
      params do
        use :requires_ad_id, :optional_ad_attribs, :optional_coordinates
      end
      route_param :id do
        put do
          ad = current_user.ads.find(params[:id])
          if ad.update(permitted_params)
            present :ad, ad, with: V1::Entities::Ads
          else
            error! ad.errors, 400
          end
        end
      end

      desc 'Change state of ad, applies only to the signed in user\'s ads'
      params { use :requires_ad_id, :requires_transition }
      route_param :id do
        put 'event/:transition' do
          ad = current_user.ads.find(params[:id])
          if ad.fire_state_event(params[:transition])
            present :ad, ad, with: V1::Entities::Ads
          else
            error! ad.errors, 400
          end
        end
      end

      desc 'Create new ad'
      params do
        use :requires_coordinates, :requires_ad_attribs, :requires_prospect_image
      end
      post do
        attachment =  handle_image
        lat_lon = { lat: params[:lat], lon: params[:lon] }
        ad = Ad.new(permitted_params.merge(
          user:        current_user,
          coordinates: lat_lon,
          prospect_image: attachment)
        )

        if ad.save
          ad.prospect_image.save
          present :ad, ad, with: V1::Entities::Ads
        else
          error! ad.errors, 400
        end
      end

    end
  end
end
