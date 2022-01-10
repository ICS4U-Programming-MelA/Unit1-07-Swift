// Copyright (c) 2022 Mel Aguoth All rights reserved.
//
// Created By: Mel Aguoth
// Date: January 6, 2022
// Obtains student names and assignments from two different text files, and adds them
// to a 2D array along with random numbers for their marks.

// Import modules.
import Foundation

func generateMarks(students: [String], assignments: [String]) -> [[String]] {

  // Declare constants.
  let assignNum: Int = assignments.count
  let studentNum: Int = students.count

  // Declare variables.
  var markArray = Array(repeating: Array(repeating: "", count: assignNum + 1), count: studentNum + 1)

  // Add the student names, assignments, and marks to the array.
  markArray[0][0] = "Student"
  for assignColumn in 1..<assignments.count {
    markArray[0][assignColumn] = assignments[assignColumn - 1]
  }
  for nameRow in 1..<students.count {
    markArray[nameRow][0] = students[nameRow - 1]
  }
  for column in 1..<assignments.count {
    for row in 1..<students.count {
      let mark = Int.random(in: 50...100)
      markArray[row][column].append(String(mark))
    }
  }

  // Return the array.
  return markArray
}

// Declare constants.
let assignments = "/home/ubuntu/ICS4U/Unit1/Unit1-07/Unit1-07-Swift/assignments/"
let studentMarks = "/home/ubuntu/ICS4U/Unit1/Unit1-07/Unit1-07-Swift/marks.csv/)"
let students = "/home/ubuntu/ICS4U/Unit1/Unit1-07/Unit1-07-Swift/students/"
let text = ""

// Declare variables.
var columns: Int = 1
var rows: Int =  1

// Introduce the program.
print("This program takes student names and assignments from two different text files and outputs"
    + " them to a CSV file called 'marks' along with their grades.")

// Read the assignments from their text file and through a list into their array.
let assignFile: String = try String(contentsOfFile: assignments)
let assignArray: [String] = assignFile.components(separatedBy: "\n")

// Read the student names from their text file and through a list into their array.
let studentFile: String = try String(contentsOfFile: students)
let studentArray: [String] = studentFile.components(separatedBy: "\n")

// Call generateMarks.
var marks: [[String]] = generateMarks(students: studentArray, assignments: assignArray)

// Add the 2D array to a csv file.
try text.write(to: URL(fileURLWithPath: "/home/ubuntu/ICS4U/Unit1/Unit1-07/Unit1-07-Swift/marks.csv"),
               atomically: false, encoding: .utf8)
if let fileWriter = try? FileHandle(forUpdating:
    URL(fileURLWithPath: "/home/ubuntu/ICS4U/Unit1/Unit1-07/Unit1-07-Swift/marks.csv")) {
  for array in marks {
    let arrayToString = array.joined(separator: "       ") + "\n"
    fileWriter.seekToEndOfFile()
    fileWriter.write(arrayToString.data(using: .utf8)!)
  }
  fileWriter.closeFile()
}
print("Marks written.")
