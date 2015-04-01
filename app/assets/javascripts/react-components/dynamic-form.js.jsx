$( document ).ready( function()  {

  var fieldValues = {
    name              : null,
    populate_at       : null,
    same_as           : null,
    autocomplete_from : null,
    title             : null
  }


  var DynamicForm = React.createClass({
    //getDefaultProps: function() {
    //  pop_vals = [:automatically, :web_start, :web_end]
    //  return { populate_at: pop_vals }
    //}

    render: function() {
      return (
        <div>
          <label>Name</label>
          <input type="text" ref="name" defaultValue='hi' />
          <Select data={this.props.populate_at} />
          <button onClick={this.saveAndContinue}>Save and Continue</button>
        </div>
      );
    },
    saveAndContinue: function(e) {
      e.preventDefault()

      // Get values via this.refs
      var data = {
        name     : this.refs.name.getDOMNode().value,
      }
      console.log('data: ' + data['name'])

    }
  })


  var mountpoint = document.getElementById('dynamic-form')
  if ( mountpoint ) {
    React.render(<DynamicForm />, mountpoint);
  };

});


