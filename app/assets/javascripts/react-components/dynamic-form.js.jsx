$( document ).ready( function()  {

  var fieldValues = {
    name              : null,
    populate_at       : null,
    same_as           : null,
    autocomplete_from : null,
    title             : null
  };

  var data = {
  populate_at: ['automatically', 'web_start', 'web_end'],
  autocomplete_from: ['customer_name', 'customer_address',
                        'project_address', 'worker_names']
  };


  var PopulateAtCheckboxes = React.createClass({
    render: function() {
      globProps= this.props;
      var populateAtCheckbox = this.props.populate_at.map(function(value) {
        return (
          // `key` is a React-specific concept and is not mandatory for the
          // purpose of this tutorial. if you're curious, see more here:
          // http://facebook.github.io/react/docs/multiple-components.html#dynamic-children
         <label for={value}>
             <input type="checkbox" name={value} value="{value}"/>
             {value}
         </label>
        );
      });
      return (
        <div classname="populate-at-checkboxes">
          {populateAtCheckbox}
        </div>
      );
    }
  });

  var AutocompleteFromCheckboxes = React.createClass({
    render: function() {
      if (typeof autocomplete_from != "undefined") {
         var option = autocomplete_from.map( function(value) {
           return (
             <label for={value}>
               <input type="checkbox" name={value} value="{value}"/>
               {value}
             </label>
           );
         });
         return (
           <span> loading.. </span>
         );
      }
      else {
        return (
          <span> NADA </span>
        );
      }
    }
  });

  var DynamicForm = React.createClass({
    saveAndContinue: function(e) {
      e.preventDefault();
      //var data = {
      //  name     : this.refs.name.getDOMNode().value,
      //};
      //console.log('data: ' + data.name);
    },

    render: function() {
      globProps= this.props;
      return (
        <div>
          <label>Velg navn på felt</label>
          <input type="text" ref="name" defaultValue='' />
          <strong> Når skal verdien fylles inn? </strong>
          <PopulateAtCheckboxes populate_at={this.props.data.populate_at} />

          <strong> Autocomplete med data fra </strong>
          <AutocompleteFromCheckboxes
            autocomplete_from={this.props.data.autocomplete_from} />
          <br/>
          <br/>
          <button onClick={this.saveAndContinue}>Save and Continue</button>
        </div>
      );
    }
  });


  var mountpoint = document.getElementById('dynamic-form');
  if ( mountpoint ) {
    React.render(<DynamicForm data={data} />, mountpoint);
  }

});


