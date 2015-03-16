$( document ).ready( function()  {

  var TestResultBox = React.createClass({
    loadTestScoreFromServer: function() {
      $.ajax({
        url: this.props.url,
        dataType: 'json',
        success: function(data) {
          this.setState({data: data});
        }.bind(this),
        error: function(xhr, status, err) {
          console.error(this.props.url, status, err.toString());
        }.bind(this)
      });
    },
    getInitialState: function() {
      return {data: [], user_id: ''};
    },
    getDefaultProps: function() {
      var user_id = $('#user-info').data('id');
      url= "http://hse.orwapp.com/api/scores?user_id=" + user_id;
      return { url: url }
    },
    componentDidMount: function() {
      this.loadTestScoreFromServer();
      setInterval(this.loadCommentsFromServer, 2000);
    },
    render: function() {
      return (
        <div className="testResultBox">
          <TestResultList data={this.state.data} />
        </div>
      );
    }
  });

  var TestResultList = React.createClass({
    render: function() {
      if (typeof this.props.data['scores'] != "undefined") {
         var testNodes = this.props.data['scores'].map( function(score) {
           return (
             <Test name={score['course']['name']} percent={score['percent']}>
             </Test>
           );
         });
        return (
          <div className="testList">
            {testNodes}
          </div>
        );
      }
      else {
        return (
          //<img src='/assets/spinner_30x30.gif'/>
          <img/>
        );
      }
    }
  });


  var Test = React.createClass({
    render: function() {
        return (
          <div className="test">
            <strong className="testTitle">
              {this.props.name}
            </strong>
            <span> {this.props.percent} % riktig </span>
          </div>
        );
      }
  });

  React.render(
    <TestResultBox />,
    document.getElementById('test-scores')
  );

});
