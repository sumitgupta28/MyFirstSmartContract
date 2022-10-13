// SPDX-License-Identifier: GPL-3.0


pragma solidity >=0.4.0 < 0.9.0;

contract ScoreCard {

    uint256 studentCount=0;
    address public classTeacher;

    constructor(){
        classTeacher = msg.sender;
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

    function addStudentDetails(string memory _studentFirstName, string memory _studentLastName) public
    {
        StudentDetails storage studentObject = students[studentCount];
        studentObject.studentFirstName = _studentFirstName;
        studentObject.studentLastName = _studentLastName;
        studentObject.id = studentCount;
        studentCount++;
    }

    function addStudentScore(uint256 _studentId, uint256 _englishMarks,uint256 _mathsMarks,uint256 _scienceMarks) public {

        Score storage scoreObject  = scores[_studentId];

        scoreObject.englishMarks =_englishMarks;
        scoreObject.scienceMarks = _scienceMarks;
        scoreObject.mathsMarks = _mathsMarks;
        scoreObject.studentId =_studentId;
    }

}