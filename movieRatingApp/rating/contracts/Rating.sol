// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
pragma experimental ABIEncoderV2;

contract Rating {
    // List of movie names
    string[] public moviesList;

    // This mapping keeps track of each movie rating. Note that the key is bytes32 type 
    mapping (bytes32 => uint8) private ratings;
    // This mapping keeps track of movie names to ensure no duplicates 
    mapping (bytes32 => bool) private movies;
    // This mapping allows an account to only vote once
    mapping (address => bool) private hasVoted;
  
    constructor(string[] memory _moviesList) {
        moviesList = _moviesList;
    }

    // Adds new movie to the moviesList. Need to check whether movie already exists before adding to the list
    function addNewMovie(string memory movieName) public {
        bytes32 movieNameInBytes32 = stringToBytes32(movieName);
        require(!movies[movieNameInBytes32], "Movie already exists!");
        moviesList.push(movieName);
        movies[movieNameInBytes32] = true;
    }

    // Returns the total ratings a movie has received so far. Hint: need to convert movieName from string to bytes32
    function totalVotesFor(string memory movieName) public view returns (uint8) {
        return ratings[stringToBytes32(movieName)];
    }

    // Increments the vote count for the specified movie. Equivalent to upvoting. Hint: need to convert movieName from string to bytes32
    function voteForMovie(string memory movieName) public {

        require(!(hasVoted[msg.sender] == true), "May only vote once per account");

        ratings[stringToBytes32(movieName)] += 1;

        hasVoted[msg.sender] = true;
    }
  
    // Converts string to bytes32
    function stringToBytes32(string memory source) private pure returns (bytes32 result) {
        bytes memory tempEmptyStringTest = bytes(source);
        if (tempEmptyStringTest.length == 0) {
            return 0x0;
        }
    
        assembly {
            result := mload(add(source, 32))
        }
    }

    function getMoviesList() public view returns (string[] memory _moviesList){
        string [] memory _movieList = moviesList;
        return _movieList;
    }
}