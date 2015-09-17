var AttachmentFields = React.createClass({
  getInitialState: function() {
    return {
      data: JSON.parse(this.props.data)
    }
  },
  onClick: function() {
    this.state.data.push({id: null, description: ''});
    this.setState({data: this.state.data});
  },
  render: function () {
    var model = this.props.model;
    return (
      <div className="attachments">
        {this.state.data.map(function (elt) {
          id = elt.id || Date.now();
          return (
            <div className="field">
              <input 
              type="hidden" 
              name={model + '[attachments_attributes][' + id + '][id]'} 
              id={model + '_attachments_attributes_' + id + '_id'}
              value={elt.id} />
              <label 
              htmlFor={model + '_attachments_attributes_' + id + '_document'}>
                Velg vedlegg
              </label>
              <input 
              type="file" 
              name={model + '[attachments_attributes][' + id + '][document]'} 
              id={model + '_attachments_attributes_' + id + '_document'} />
              <input 
              placeholder="Filbeskrivelse" 
              type="text" 
              name={model + '[attachments_attributes][' + id + '][description]'} 
              id={model + '_attachments_attributes_' + id + '_description'} 
              value={elt.description}/>
            </div>
          )
        }, this)}
        <input 
          type="button" 
          className="btn btn-default plus-button" 
          type="button" 
          onClick={this.onClick} 
        value="+" />
      </div>
      )
  }
})

