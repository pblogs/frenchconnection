$( document ).ready(function() {
'use strict';

var FormTitle = React.createClass({
  render: function() {
    return (
      <form>

        <h2> {this.props.title} </h2>
        <span></span>
      </form>
    );
  }
});
var InputWithLabel = React.createClass({
  // Could be rewritten with different onChange handlers, for now it only works
  // with title.
  displayName: "inputWithLabel",
  handleChange: function (e) {
    actions.updateTitle(e.target.value, this.props.name);
  },
  render: function() {
    return (
      <label htmlFor={this.props.value}>
        <input name={this.props.value} type={this.props.type}
          onChange={this.handleChange} defaultValue={this.props.value}/>
      </label>
    );
  }
});

var DynamicForm = React.createClass({
  getInitialState: function() {
    var rows = {};
    rows[0] = { autocomplete_from: 'customer_name', populate_at: 'web_start',
                title: 'field 1' };
    return {data: rows };
  },
  componentDidMount: function() {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      success: function(data) {
        this.setState({data: data.rows});
        console.log("State set to: ", this.state.data);
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },
  render: function() {
    return (
      <div>
        <h2> {this.state.data.form_title} </h2>
      </div>
    );
  }
});

var mountpoint = document.getElementById('dynamic-form-show');
if ( mountpoint ) {
  var id = $('#dynamic-form-id').text();
  $.trim(id);
  var url = "http://localhost:4000/dynamic_forms/"+id+".json";
  React.render(<DynamicForm url={url}/>, mountpoint);
}


});
