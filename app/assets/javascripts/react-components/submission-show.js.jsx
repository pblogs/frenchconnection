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
  render: function() {
    return (
      <div htmlClass="field">
        <label htmlFor={this.props.title}> {this.props.title} </label>
        <input disabled={this.props.disabled} className="active-input"
          id={this.props.title} value={this.props.value} type="text"/>
      </div>
    );
  }
});

var Submission = React.createClass({
  getInitialState: function() {
    var values = {};
    values.getInitialState = 1;
    return { title: 'title from initial state', values };
  },
  componentDidMount: function() {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      success: function(data) {
        this.setState( { values: data.values, title: data.title });
      }.bind(this),
      error: function(xhr, status, err) {
        console.log("Error fetching state", err);
      }
    });
  },
  render: function() {
    return (
      <div>
        <h2> {this.state.title} </h2>
        { Object.keys(this.state.values).map(function (key, i, v) {
          return (
            <div>
              <InputWithLabel disabled={true} key={key}
                title={key} value={this.state.values[key]} />
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
var url = "/submissions/"+id+".json";
  React.render(<Submission url={url}/>, mountpoint);
}


});
