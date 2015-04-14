'use strict';

var form_fields = {
  populate_at: ['automatically', 'web_start', 'web_end'],
  autocomplete_from: ['customer_name', 'customer_address',
    'project_address', 'worker_names', 'project_name', 'user_name']
};


var actions = Reflux.createActions( [
  'updateAutoComplete'
]);

var rows = {};
rows[0] = { autocomplete_from: 'customer_name' };
rows[1] = { autocomplete_from: 'project_name' };

var store = Reflux.createStore({
  listenables: [actions],

  onUpdateAutoComplete(checked, id){
    console.log('checked in onUpdateAutcomplete:', checked);
    rows[id].autocomplete_from = checked;
    this.trigger({rows}); // <== Causes an infinite loop when included.
  },
  getInitialState: function() {
    return { rows:rows };
  },
});



var AutoCompleteFrom = React.createClass({
  mixins: [Reflux.connect(store)],
  handleChange: function(event) {
    console.log('checked in handleChange: ', event);
    actions.updateAutoComplete(event.target.value, event.target.name);
  },

  render: function() {
    var autocompleteFrom = this.props.autocomplete_from.map(function(value) {
      return (
        <label key={value} htmlFor={value}>
          <input type="radio" name={this.props.id} value={value} row={this.props.id}
            onChange={this.handleChange} checked={this.props.checked == value}
          />
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
  mixins: [Reflux.connect(store)],

  render: function() {
    var _this = this;
    return (
      <div>
         <div>
            <strong>Autocomplete status read through state:</strong>
            <br/>
            <span htmlClass="status"> 0: {_this.state.rows[0]} </span>
            <br/>
            <span htmlClass="status"> 1: {_this.state.rows[1]} </span>
        </div>
        <br/>
        <br/>

        { Object.keys(this.state.rows).map(function (key,i) {
          var row = _this.state.rows[key];
          return (
            <div key={key} >
              <strong> AutoCompleteFrom</strong>
              <AutoCompleteFrom checked={row.autocomplete_from}
                id={i} rows={this.state.rows} autocomplete_from={form_fields.autocomplete_from} />
              <br/>
              <br/>
              <hr/>
            </div>
            );
        }, this)}
      </div>
    );
  this}
});



var mountpoint = document.getElementById('dynamic-form');
if ( mountpoint ) {
  React.render(<DynamicForm/>, mountpoint);
}

