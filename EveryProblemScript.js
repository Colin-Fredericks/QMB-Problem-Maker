$(document).ready(function(){
    console.log('Every Problem Script working');

    var problemID;

    $('button.submit').off('.hx').one('click.hx tap.hx', function(){
        problemID = $(this).closest('.xblock').attr('data-usage-id');
        onCheckButton(problemID);
    });

    function afterButtonPress(problemID){

        // Add new listener to the submit button.
        var theButton = $('div.xblock[data-usage-id="' + problemID + '"]').find('button.submit');
        theButton.off('.hx').on('click.hx tap.hx', function(problemID){
            problemID = $(this).closest('.xblock').attr('data-usage-id');
            onCheckButton(problemID);
        });

        // Let our server know the grade and other info.
        // We're reading all of this straight off the page.
        // Sure wish we had a better way to do this.
        var xBlock = $('div.xblock[data-usage-id="' + problemID + '"]');
        var gradeNumber = 0;
        var maxGradeNumber = 0;

        // Check for radio buttons, checkboxes, and text boxes.
        // Whichever type of problem this is, return the
        // answer options and student selections.
        var answerOptions = [];
        var studentResponses = [];
        var radioButtons = $(xBlock).find('input:radio');
        var checkBoxes = $(xBlock).find('input:checkbox');
        var answerText = $(xBlock).find('input:text');

        // Checking for text-entry or numerical problems
        if(answerText.length > 0){
          answerOptions = 'blank';
          $.each(answerText, function(i, value){
            studentResponses.push(value.value);
          });
        }

        // Checking for MC or checkbox problems
        if(radioButtons.length > 0 || checkBoxes.length > 0){
          var options = radioButtons.length > 0 ? radioButtons : checkBoxes;
          $.each(options, function(i, value){
            answerOptions.push($.trim($(value).parent().contents().filter(function(){
              return this.nodeType == 3;
            }).text()));
            studentResponses.push(value.checked);
          });
        }

        // Get the grade
        var gradeFullText = $(xBlock).find('.problem-progress').text();
        var gradeText = gradeFullText.split(' ')[0];

        if(gradeText.length > 1){
            gradeNumber = gradeText.split('/')[0];
            maxGradeNumber = gradeText.split('/')[1];
        }else{
            maxGradeNumber = gradeText;
        }

        // Get username after button press, since analytics variable not available right away at document.ready
        try {
            var username = analytics._user._getTraits()['username'];
        }
        catch(err) {
            var username = 'No_username_found';
        }

        //Log info: edX username, problem ID, current and maximum grade.
        console.log('User: ' + username);
        console.log('Problem ID: ' + problemID);
        console.log('Current grade: ' + gradeNumber);
        console.log('Max grade: ' + maxGradeNumber);
        console.log('Response Options: ' + answerOptions);
        console.log('Student Responses: ' + studentResponses);


        // Make POST request with grade info
        $.post("https://adaptive-edx.vpal.io/api/problem_attempt", {
                user: username,
                problem: problemID,
                points: gradeNumber,
                max_points: maxGradeNumber,
                answer_options: answerOptions,
                student_response: studentResponses
            }
            ,function(data){console.log("Made POST request: "+ data.message);},"json"
        );

    }

    function onCheckButton(problemID){

        // Wait before rebinding the listeners and getting the log info.
        setTimeout(afterButtonPress.bind(null, problemID), 2000);
    }

});
