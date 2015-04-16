'use strict';

var form_fields = {
  populate_at: ['automatically', 'web_start', 'web_end'],
  autocomplete_from: ['customer_name', 'customer_address',
    'project_address', 'worker_names', 'project_name', 'user_name']
};


var actions = Reflux.createActions( [
  'updateAutoComplete',
  'updatePopulateAt'
]);

var rows = {};
rows[0] = { autocomplete_from: 'customer_name', populate_at: 'web_start' };
rows[1] = { autocomplete_from: 'project_name',  populate_at: 'web_end' };

var store = Reflux.createStore({
  listenables: [actions],

  onUpdatePopulateAt(checked, id){
    console.log('checked in POPULATE AT:', checked);
    rows[id].populate_at = checked;
    this.trigger({rows});
  },
  onUpdateAutoComplete(checked, id){
    console.log('checked in onUpdateAutcomplete:', checked);
    rows[id].autocomplete_from = checked;
    this.trigger({rows});
    this.forceUpdate;
  },

  getInitialState: function() {
    return { rows:rows };
  },
});


var PopulateAt = React.createClass({
  mixins: [Reflux.connect(store)],
  handleChange: function(event) {
    console.log('PopulateAt - checked in handleChange: ', event);
    actions.updatePopulateAt(event.target.value, event.target.name);
  },

  render: function() {
    var autocompleteFrom = this.props.populate_at.map(function(value) {
      return (
        <label key={value} htmlFor={value}>
          <input type="radio" name={this.props.id}
            value={value} row={this.props.id}
            onChange={this.handleChange} checked={this.props.checked == value}
          />
          {value}
        </label>
      );
    }, this);
    return (
      <div className="checkboxes">
        {autocompleteFrom}
      </div>
    );
  }
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
          <input type="radio" name={this.props.id}
            value={value} row={this.props.id}
            onChange={this.handleChange} checked={this.props.checked == value}
          />
          {value}
        </label>
      );
    }, this);
    return (
      <div className="checkboxes">
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
            <span> 0 </span>
            <span htmlClass="status">  {_this.state.rows[0].autocomplete_from} </span>
            <span htmlClass="status">  {_this.state.rows[0].populate_at} </span>
            <br/>
            <span> 1 </span>
            <span htmlClass="status">  {_this.state.rows[1].autocomplete_from} </span>
            <span htmlClass="status">  {_this.state.rows[1].populate_at} </span>
        </div>
        <br/>
        <br/>

        { Object.keys(this.state.rows).map(function (key,i) {
          var row = _this.state.rows[key];
          return (
            <div key={key} >

              <strong> AutoCompleteFrom</strong>
              <AutoCompleteFrom checked={row.autocomplete_from}
                id={i} rows={this.state.rows}
                autocomplete_from={form_fields.autocomplete_from} />

              <strong> PopulateAt</strong>
              <PopulateAt checked={row.populate_at}
                id={i} rows={this.state.rows}
                populate_at={form_fields.populate_at} />

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

