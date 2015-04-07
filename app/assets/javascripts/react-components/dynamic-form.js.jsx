$( document ).ready( function()  {
  'use strict';

  var data = {
    populate_at: ['automatically', 'web_start', 'web_end'],
    autocomplete_from: ['customer_name', 'customer_address',
      'project_address', 'worker_names']
  };


  var PopulateAtCheckboxes = React.createClass({
    handleChange: function(e) {
      console.log('populateAtCheckbox');
      return 1;
    },
    render: function() {
      var populateAtCheckbox = this.props.populate_at.map(function(value) {
        return (
          <label for={value}>
            <input type="checkbox" name={value} value="{value}"
              onChange={this.handleChange}
              ref="populate-at"/>
            {value}
          </label>
        );
      }, this);
      return (
        <div className="populate-at-checkboxes">
          {populateAtCheckbox}
        </div>
      );
    }
  });

  var AutocompleteFromCheckboxes = React.createClass({
    handleChange: function(e) {
      this.setState( { autocomplete_from: event.target.value },
        function () {
          console.log('autocompleteFrom state: ', this.state.autocomplete_from);
        }
      );
    },
    render: function() {
      var autocompleteFrom = this.props.autocomplete_from.map(function(value) {
        return (
          <label for={value}>
            <input type="checkbox" name={value} value={value}
              onChange={this.handleChange}
              ref="autocomplete-from"/>
            {value}
          </label>
        );
      }, this);
      return (
        <div className="autocomplete-from">
          {autocompleteFrom}
        </div>
      );
    }
  });

  var DynamicForm = React.createClass({
    getInitialState: function() {
      return {
        name              : null,
        populate_at       : null,
        same_as           : null,
        autocomplete_from : "not set",
        title             : null
      };
    },
    saveAndContinue: function(e) {
      e.preventDefault();
      var data = {
        name     : this.refs.name.getDOMNode().value,
      };
      console.log('data: ' + data.name);
    },

    render: function() {
      return (
        <div>
          <label>Velg navn på felt</label>
          <input type="text" ref="title" defaultValue='' />
          <strong> State.autocomplete_from: {this.state.autocomplete_from} </strong>
          <br/>
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


