$( document ).ready( function()  {

  var fieldValues = {
    name              : null,
    populate_at       : null,
    same_as           : null,
    autocomplete_from : null,
    title             : null
  }

  var DynamicForm = React.createClass({
    render: function() {
      return (
        <div>
          <label>Name</label>
          <input type="text" ref="name" defaultValue={this.props.fieldValues.name} />
          <button onClick={this.saveAndContinue}>Save and Continue</button>
        </div>
      );
    }

  });
    saveAndContinue: function(e) {
      e.preventDefault();

      //// Get values via this.refs
      //var data = {
      //  name     : this.refs.name.getDOMNode().value,
      //  password : this.refs.password.getDOMNode().value,
      //  email    : this.refs.email.getDOMNode().value,
      //}

      //this.props.saveValues(data)
      //this.props.nextStep()
    }


  //var dynamic_form = document.getElementById('dynamic-form')
  //if ( dynamic_form ) {
  //  React.render(<DynamicForm />, dynamic_form)
  //};

});
