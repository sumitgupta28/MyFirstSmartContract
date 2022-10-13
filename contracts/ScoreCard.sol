// SPDX-License-Identifier: GPL-3.0


pragma solidity >=0.4.0 < 0.9.0;

contract ScoreCard {

    uint256 studentCount=0;
    address public classTeacher;

    constructor(){
        classTeacher = msg.sender;
    }

    /**
    this modifire allows only class teacher address to acess.
    this method call would be added to methods which only suppose to be called by 
    class teacher. In this we added it to both addStudent and addScoreCard. 
    **/
    modifier onlyClassTeacher( address _classTeacher){
        require(classTeacher ==_classTeacher,"Only the class teacher has access to this function");
        _;
    }

    struct StudentDetails{
        string studentFirstName;
        string studentLastName;
        uint256 id;
    }

    struct Score {
        uint256 studentId;
        uint256 englishMarks;
        uint256 mathsMarks;
        uint256 scienceMarks;
    }

    mapping (uint => StudentDetails) students;
    mapping(uint => Score) scores;



    event studentAdded(string  _studentFirstName, string  _studentLastName,uint256 _studentId );

    event studentStudentScoresRecorded(uint256 _studentId, uint256 _englishMarks,uint256 _mathsMarks,uint256 _scienceMarks);


    function addStudentDetails (string memory _studentFirstName, string memory _studentLastName) public
    onlyClassTeacher(msg.sender)
    {
        StudentDetails storage studentObject = students[studentCount];
        studentObject.studentFirstName = _studentFirstName;
        studentObject.studentLastName = _studentLastName;
        studentObject.id = studentCount;
        emit studentAdded(_studentFirstName,_studentLastName,studentCount);
        studentCount++;
    }

    function addStudentScore(uint256 _studentId, uint256 _englishMarks,uint256 _mathsMarks,uint256 _scienceMarks) public 
        onlyClassTeacher(msg.sender)

    {

        Score storage scoreObject  = scores[_studentId];

        scoreObject.englishMarks =_englishMarks;
        scoreObject.scienceMarks = _scienceMarks;
        scoreObject.mathsMarks = _mathsMarks;
        scoreObject.studentId =_studentId;
        emit studentStudentScoresRecorded(_studentId,_englishMarks,_mathsMarks,_scienceMarks);
    }

}