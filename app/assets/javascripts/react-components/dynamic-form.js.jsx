$( document ).ready(function() {
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
  'updateTitle',
  'updateFormTitle',
]);

var rows = {};
rows['form_title']  = '';
rows[0] = { autocomplete_from: 'customer_name', populate_at: 'web_start',
  title: 'field 1' };
rows[1] = { autocomplete_from: 'project_name',  populate_at: 'web_end',
  title: 'field 2'};

var store = Reflux.createStore({
  listenables: [actions],

  onUpdateFormTitle: function(form_title){
    console.log('update', form_title)
    rows['form_title'] = form_title;
    this.trigger(rows);
  },
  onUpdatePopulateAt: function(checked, id){
    rows[id].populate_at = checked;
    this.trigger(rows);
  },
  onUpdateAutoComplete: function(checked, id){
    console.log('checked in onUpdateAutcomplete:', checked);
    rows[id].autocomplete_from = checked;
    this.trigger(rows);
  },
  onUpdateTitle: function(value, id){
    rows[id].title = value;
    this.trigger(rows);
  },
  onNewField: function(){
    var id = '';
    Object.keys(rows).map(function (key,i) { id = parseInt(i) } );
    id++;
    rows[id] = { autocomplete_from: 'customer_name',
                 populate_at: 'web_start',
                 title: 'nytt fra knappen'
                };
    this.trigger(rows);
  },

  getInitialState: function() {
    return { rows:rows };
  },
});


var PopulateAt = React.createClass({
  mixins: [Reflux.connect(store)],
  handleChange: function(e) {
    actions.updatePopulateAt(e.target.value, e.target.name);
  },

  render: function() {
    var checkboxes = this.props.populate_at.map(function(value) {
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
        {checkboxes}
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

var FormTitle = React.createClass({
  // Could be rewritten with different onChange handlers, for now it only works
  // with title.
  displayName: "FormTitle",
  handleChange : function (e) {
    actions.updateFormTitle(e.target.value);
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
    actions.newField();
  },
  render: function() {
    return (
      <button type="button" onClick={this.submit}> {this.props.text} </button>
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
      }),
      statusCode: {
        200: function (response) {
          location.href = response.responseText;
        },
        500: function (response) {
        }
      }
    });
  },
  render: function() {
    return (
      <button type="button" onClick={this.submit}> {this.props.text} </button>
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

          <strong> Navnet på skjemaet </strong>
          <FormTitle type="text" value={this.state.form_title}/>

          <hr/>
          <br/>
          <br/>

          { Object.keys(this.state.rows).map(function (key,i) {
            if (key === 'form_title') { return; }
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
        <SubmitButton text="Lagre" state={this.state}
                      url="http://localhost:4000/dynamic_forms"/>
      </div>
    );
  this}
});



var mountpoint = document.getElementById('dynamic-form');
if ( mountpoint ) {
  React.render(<DynamicForm/>, mountpoint);
}

});
