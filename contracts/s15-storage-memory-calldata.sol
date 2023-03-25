// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
Data location:
    1. Storage: Persistent data on the blockchain (state variables)
    2. Memory: Temporary data
    3. Calldata: Read-only temporary data used for function arguments
*/

struct Student {
    string name;
    uint age;
    uint16 grade;
}

contract School {
    uint256 public studentCount = 0; // Storage
    mapping(uint => Student) public students; // Storage

    // Calldata
    function addStudent(string calldata _name, uint _age, uint16 _grade) public {
        studentCount++;
        students[studentCount] = Student(_name, _age, _grade);
    }

    function changeStudentInfo(uint _studentId, string calldata _name, uint _age, uint16 _grade) public {
        Student storage student = students[_studentId];
        student.name = _name;
        student.age = _age;
        student.grade = _grade;
    }

    // Memory (not recommended)
    function changeStudentInfoMemory(uint _studentId, string memory _name, uint _age, uint16 _grade) public {
        Student memory student = students[_studentId];
        student.name = _name;
        student.age = _age;
        student.grade = _grade;
    }

    function getStudentName(uint _studentId) public view returns (string memory) {
        return students[_studentId].name;
    }
}
