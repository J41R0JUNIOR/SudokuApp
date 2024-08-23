////
////  SudokuLogic.swift
////  Sudoku
////
////  Created by Jairo Júnior on 22/08/24.
////
//
//import Foundation
//
//exports.handler = async (event, context) => {
//  function sudokuGenerator() {
//    const size = 9;
//    const grid = [];
//    for (let i = 0; i < size; i++) {
//      const row = [];
//      for (let j = 0; j < size; j++) {
//        row.push(0);
//      }
//      grid.push(row);
//    }
//
//    fillGrid(grid, 0, 0);
//    return grid;
//  }
//
//  function fillGrid(grid, row, col) {
//    const size = 9;
//    if (col === size) {
//      col = 0;
//      row++;
//      if (row === size) {
//        return true;
//      }
//    }
//
//    if (grid[row][col] !== 0) {
//      return fillGrid(grid, row, col + 1);
//    }
//
//    const numbers = shuffle([1, 2, 3, 4, 5, 6, 7, 8, 9]);
//
//    for (let i = 0; i < numbers.length; i++) {
//      const num = numbers[i];
//      if (isValid(grid, row, col, num)) {
//        grid[row][col] = num;
//        if (fillGrid(grid, row, col + 1)) {
//          return true;
//        }
//        grid[row][col] = 0;
//      }
//    }
//
//    return false;
//  }
//
//  function isValid(grid, row, col, num) {
//    return (
//      !usedInRow(grid, row, num) &&
//      !usedInCol(grid, col, num) &&
//      !usedInBox(grid, row - (row % 3), col - (col % 3), num)
//    );
//  }
//
//  function usedInRow(grid, row, num) {
//    for (let col = 0; col < 9; col++) {
//      if (grid[row][col] === num) {
//        return true;
//      }
//    }
//    return false;
//  }
//
//  function usedInCol(grid, col, num) {
//    for (let row = 0; row < 9; row++) {
//      if (grid[row][col] === num) {
//        return true;
//      }
//    }
//    return false;
//  }
//
//  function usedInBox(grid, boxStartRow, boxStartCol, num) {
//    for (let row = 0; row < 3; row++) {
//      for (let col = 0; col < 3; col++) {
//        if (grid[row + boxStartRow][col + boxStartCol] === num) {
//          return true;
//        }
//      }
//    }
//    return false;
//  }
//
//  function shuffle(array) {
//    for (let i = array.length - 1; i > 0; i--) {
//      const j = Math.floor(Math.random() * (i + 1));
//      [array[i], array[j]] = [array[j], array[i]];
//    }
//    return array;
//  }
//
//  var sudoku = sudokuGenerator();
//  // console.log(sudoku);
//
//
//  const difficultyArray = (level) => {
//    const easyArray = sudoku.map((row) => [...row]);
//    const numZeroes = level;
//    let count = 0;
//
//    while (count < numZeroes) {
//      const row = Math.floor(Math.random() * 9); // choose a random row index
//      const col = Math.floor(Math.random() * 9); // choose a random column index
//
//      if (easyArray[row][col] !== 0) {
//        // check if the position is already zero
//        easyArray[row][col] = 0; // set the position to zero
//        count++;
//      }
//    }
//    // console.log(easyArray);
//    return easyArray;
//  };
//
//  const data = {
//    game: "Sudoku",
//    created_by: "Amit Sharma",
//    info: "Each array in the data array represents a row in the sudoku grid.",
//    data: sudoku,
//    easy: difficultyArray(25),
//    medium: difficultyArray(45),
//    hard: difficultyArray(62),
//    date: new Date().toISOString(), // 2021-03-31T18:30:00.000Z
//    rules: [
//      "Each row must contain the numbers 1-9 without repetition.",
//      "Each column must contain the numbers 1-9 without repetition.",
//      "Each of the nine 3x3 sub-boxes of the grid must contain the numbers 1-9 without repetition.",
//      "The sum of every single row, column and 3x3 box must be 45.",
//    ],
//    difficulty: [
//      "The difficulty is determined by the number of clues given.",
//      "The fewer clues, the harder the puzzle.",
//      "The more clues, the easier the puzzle.",
//    ],
//    projects: [
//      {
//        title: "EVSTART: Electric Vehicle is the Future",
//        url: "https://evstart.netlify.app/",
//      },
//      {
//        title: "News Website in react",
//        url: "https://newsmon.netlify.app/",
//      },
//      {
//        title: "Hindi jokes API",
//        url: "https://hindi-jokes-api.onrender.com/",
//      },
//    ],
//    usefullinks: [
//      {
//        title: "6 Advanced Sudoku Strategies explained",
//        url: "https://www.sudokuonline.io/tips/advanced-sudoku-strategies",
//      },
//      {
//        title: "Sudoku techniques",
//        url: "https://www.conceptispuzzles.com/index.aspx?uri=puzzle/sudoku/techniques",
//      },
//    ],
//  };
//
//  return {
//    statusCode: 200,
//    body: JSON.stringify(data),
//  };
//};
