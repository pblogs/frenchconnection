$( document ).ready(function() {
'use strict';

var SubmitButton = React.createClass({
  displayName: "SubmitButton",
  fetch_values: function() {
    var map = {};
    $(".active-input").each(function() {
        map[$(this).attr("id")] = $(this).val();
    });
    return map;
  },
  submit: function(e) {
    var values = this.fetch_values();

    console.group("Submit");
    console.log("Values: ", values);
    console.log("dynamic_form_id: ", this.props.dynamic_form_id);
    console.groupEnd();
    $.ajax({
      url: this.props.url,
      type: 'POST',
      dataType: 'JSON',
      contentType: "application/json",
      processData: false,
      data: JSON.stringify({
        values: values,
        dynamic_form_id: this.props.dynamic_form_id
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
    );
  }
});

var FormTitle = React.createClass({
  render: function() {
    return (
      <h2> {this.props.title} </h2>
    );
  }
});

var InputWithLabel = React.createClass({
  displayName: "inputWithLabel",
  handleChange: function (e) {
    // actions.updateTitle(e.target.value, this.props.name);
  },
  render: function() {
    return (
      <div htmlClass="field">
        <label htmlFor={this.props.title}> {this.props.title} </label>
        <input disabled={this.props.disabled} className="active-input"
          id={this.props.title} type="text" onChange={this.handleChange} />
      </div>
    );
  }
});

var Submission = React.createClass({
  getInitialState: function() {
    var values = {};
    values.getInitialState = 1;
    values.title = 'title';
    return {title: 'title', values};
  },
  componentDidMount: function() {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      success: function(data) {
        console.log("Saving to state: ", data);
        this.setState({data});
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },
  render: function() {
    return (
      <div>
        <h2> Form title: {this.state.title} </h2>
        { Object.keys(this.state.values).map(function (key, i) {
          return (
            <div>
              <strong> {key} </strong>
              <InputWithLabel disabled={true} key={key}
                title={key} />
            </div>
          );
        }, this)}
      </div>
    );
  }
});

var mountpoint = document.getElementById('submission-show');
if ( mountpoint ) {
  var id = $.trim( $('#submission-id').text() );
  var url = "http://localhost:4000/submissions/"+id+".json";
  React.render(<Submission url={url}/>, mountpoint);
}


});
