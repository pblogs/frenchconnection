Fabricator(:customer_message) do
  text { ['Jeg er 30 minutter forsinket. Beklager så mye.', 
        'Vi er ferdig for i dag. Vi kommer tilbake i morgen.', 
        'Vi er ferdige med jobben. Vi håper du blir fornøyd.' ].sample }
end
