$( document ).ready( function()  {
  'use strict';

  var form_fields = {
    populate_at: ['automatically', 'web_start', 'web_end'],
    autocomplete_from: ['customer_name', 'customer_address',
      'project_address', 'worker_names', 'project_name', 'user_name']
  };


  var actions = Reflux.createActions(
    ['updateName']
  );

  var rows = {};
  rows[0] = { name: 'FIELD 1', populate_at: 'web_start',
              same_as: 'customer_name',
              autocomplete_from: 'customer_name', title: '' };
  rows[1] = { name: 'FIELD 2', populate_at: 'web_end',
              same_as: 'user_name', autocomplete_from: 'user_name',
              title: '' };


  var store = Reflux.createStore({
    listenables: [actions],

    onUpdateName(){
      console.log('from onUpdateName');
      rows[0].name = 'via REFLUX';
      this.trigger({rows});
    },
    init: function() {
      rows[0].name = ' oppdatert fra init ';
      this.trigger(rows);
    },
    getInitialState: function() {
      return { rows:rows };
    },
  });



  //var PopulateAtCheckboxes = React.createClass({
  //  handleChange: function (e) {
  //    console.log('handleChange');
  //    this.setState( { rows: 'klj' },
  //                  function() { console.log('state set'); }.bind(this)
  //                 );
  //},

  //render: function() {
  //  var populateAtCheckbox = this.props.populate_at.map(function(value) {
  //    return (
  //      <label for={value}>
  //        <input type="radio" name={'populate_at'+this.props.id} value={value}
  //          onChange={this.handleChange} checked={this.props.checked == value}
  //          ref="populate-at"/>
  //        {value}
  //      </label>
  //    );
  //  }, this);
  //  return (
  //    <div className="populate-at-checkboxes">
  //      {populateAtCheckbox}
  //    </div>
  //  );
  //  }
  //});

var AutoCompleteFrom = React.createClass({
  mixins: [Reflux.connect(store)],
  handleChange: function(e) {
    var id  = this.props.id;
    var row = this.props.rows[id];
    var new_autocomplete_from_value = e.target.value;
    var newRows = this.props.rows;
    newRows[id] = { autocomplete_from: new_autocomplete_from_value };

    console.log('new state:', { rows: newRows });
    //this.setState({ rows: newRows });
    //actions.updateName;

    //rows[1].name = new_autocomplete_from_value;
    //this.trigger(rows);

    //this.setState( { rows[id]: { autocomplete_from: new_autocomplete_from_value } },
    //              function () { console.log('autocompleteFrom state: ',
    //                                        this.state.autocomplete_from); }, this
    //             );
  },
  render: function() {
    var autocompleteFrom = this.props.autocomplete_from.map(function(value) {
      return (
        <label for={value}>
          <input type="radio" name={'autocomplete_from'+this.props.id} value={value}
            onChange={actions.updateName} checked={this.props.checked == value}
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

var FieldName = React.createClass({
  render: function () {
    return (
      <input id="field_name" type="text" ref="field_name"
        defaultValue={this.props.name} />
    );
  }
});

var DynamicForm = React.createClass({
  mixins: [Reflux.connect(store)],


  saveAndContinue: function(e) {
    e.preventDefault();
    var val = document.getElementById('field_name').value;
    this.setState( { field_name: val },
                  function () {
                    console.group('State');
                    console.log('autocomplete_from: ', this.state.autocomplete_from);
                    console.log('field_name: ', this.state.field_name);
                    console.log('populate_at: ', this.state.populate_at);
                    console.groupEnd();
                  });
                  this.setState( { field_name: val } );
  },


  render: function() {
    var _this = this;
    return (
      <div>
         <div>
            <strong>State status</strong>
            <span class="status"> {_this.state.rows} </span>
        </div>
        <br/>
        <br/>

        { Object.keys(this.state.rows).map(function (key,i) {
          var row = _this.state.rows[key];
          return (
            <div>
              <label>Velg navn på felt</label>
              <FieldName name={row.name}/>
              <br/>
              <strong> Når skal verdien fylles inn? </strong>

              <strong> Autocomplete med data fra </strong>
              <AutoCompleteFrom checked={row.autocomplete_from}
                id={i} rows={this.state.rows} autocomplete_from={form_fields.autocomplete_from} />
              <br/>
              <br/>
              <hr/>
            </div>
            );
        }, this)}
        <button onClick={this.newFieldEntry}>Create a new field</button>
        <button onClick={this.saveAndContinue}>Save and Continue</button>
      </div>
    );
  this}
});


var mountpoint = document.getElementById('dynamic-form');
if ( mountpoint ) {
  React.render(<DynamicForm/>, mountpoint);
}

});


