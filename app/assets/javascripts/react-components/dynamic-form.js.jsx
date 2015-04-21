'use strict';

var form_fields = {
  populate_at: ['automatically', 'web_start', 'web_end'],
  autocomplete_from: [
    'customer_name',
    'customer_address',
    'project_address',
    'worker_names',
    'project_name',
    'user_name',
  ]
};


var actions = Reflux.createActions( [
  'updateAutoComplete',
  'updatePopulateAt',
  'newField',
  'updateTitle'
]);

var rows = {};
rows[0] = { autocomplete_from: 'customer_name', populate_at: 'web_start',
  title: 'field 1' };
rows[1] = { autocomplete_from: 'project_name',  populate_at: 'web_end',
  title: 'field 2'};

var store = Reflux.createStore({
  listenables: [actions],

  onUpdatePopulateAt(checked, id){
    //console.log('checked in POPULATE AT:', checked);
    rows[id].populate_at = checked;
    this.trigger({rows});
  },
  onUpdateAutoComplete(checked, id){
    console.log('checked in onUpdateAutcomplete:', checked);
    rows[id].autocomplete_from = checked;
    this.trigger({rows});
  },
  onUpdateTitle(value, id){
    rows[id].title = value;
    this.trigger({rows});
  },
  onNewField(){
    var id = '';
    Object.keys(rows).map(function (key,i) { id = parseInt(i) } );
    id++;
    rows[id] = { autocomplete_from: 'customer_name',
                 populate_at: 'web_start',
                 title: 'nytt fra knappen'
                };
    this.trigger({rows});
  },

  getInitialState: function() {
    return { rows:rows };
  },
});


var PopulateAt = React.createClass({
  mixins: [Reflux.connect(store)],
  handleChange: function(e) {
    //console.log('PopulateAt - checked in handleChange: ', e);
    actions.updatePopulateAt(e.target.value, e.target.name);
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
  handleChange: function(e) {
    //console.log('checked in handleChange: ', e);
    actions.updateAutoComplete(e.target.value, e.target.name);
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

var InputWithLabel = React.createClass({
  // Could be rewritten with different onChange handlers, for now it only works
  // with title.
  displayName: "inputWithLabel",
  handleChange : function (e) {
    actions.updateTitle(e.target.value, this.props.name);
  },
  render: function() {
    return (
      <label htmlFor={this.props.value}>
        <input name={this.props.value} type={this.props.type}
          onChange={this.handleChange} defaultValue={this.props.value}/>
      </label>
    )
  }
});

var NewItemButton = React.createClass({
  displayName: "NewItemButton",
  mixins: [Reflux.connect(store)],
  submit: function(e) {
    //console.log('PopulateAt - checked in handleChange: ', e);
    actions.newField();
  },


  render: function() {
    return (
      <button type="button" onClick={this.submit}>
      {this.props.text} </button>
    )
  }
});

var SubmitButton = React.createClass({
  displayName: "SubmitButton",
  submit: function(e) {
    console.group("Submit");
    console.log("State: ", this.props.state);
    console.groupEnd();
    $.ajax({
      url: this.props.url,
      type: 'POST',
      dataType: 'JSON',
      contentType: "application/json",
      processData: false,
      data: JSON.stringify({
        rows:  this.props.state.rows,
        form_title:  this.props.state.form_title,
      })
    });
  },
  render: function() {
    return (
      <button type="button" onClick={this.submit}>
      {this.props.text} </button>
    )
  }
});



var DynamicForm = React.createClass({
  mixins: [Reflux.connect(store)],

  render: function() {
    var _this = this;
    return (
      <div className="outer-container">
        <div className="container">
          <div className="state-status">
            <strong>Autocomplete status read through state:</strong>
            <br/>
            <span> 0 </span>
            <span htmlClass="status"> autocomplete_from: {this.state.rows[0].autocomplete_from} </span>
            <span htmlClass="status"> populate_at: {this.state.rows[0].populate_at} </span>
            <span htmlClass="status"> title: {this.state.rows[0].title} </span>
            <br/>
            <span> 1 </span>
            <span htmlClass="status"> autocomplete_from: {this.state.rows[1].autocomplete_from} </span>
            <span htmlClass="status"> populate_at: {this.state.rows[1].populate_at} </span>
            <span htmlClass="status"> title: {this.state.rows[1].title} </span>
          </div>
          <br/>
          <br/>

          { Object.keys(this.state.rows).map(function (key,i) {
            var row = this.state.rows[key];
            return (
              <div key={key} >

                <hr/>
                <strong> Field name </strong>
                <InputWithLabel type="text" value={row.title} name={i}/>
                <hr/>

                <strong> AutoCompleteFrom </strong>
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
        <NewItemButton text="Legg til nytt felt"/>
        <SubmitButton text="Lagre" state={this.state} url="http://localhost:4000/dynamic_forms"/>
      </div>
    );
  this}
});



var mountpoint = document.getElementById('dynamic-form');
if ( mountpoint ) {
  React.render(<DynamicForm/>, mountpoint);
}

