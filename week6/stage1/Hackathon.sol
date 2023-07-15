// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Hackathon {
    struct Project {
        string title;
        uint[] ratings;
    }
    
    Project[] projects;

    // TODO: add the findWinner function

    function newProject(string calldata _title) external {
        // creates a new project with a title and an empty ratings array
        projects.push(Project(_title, new uint[](0)));
    }

    function rate(uint _idx, uint _rating) external {
        // rates a project by its index
        projects[_idx].ratings.push(_rating);
    }

    function findWinner() external view returns (Project memory) {
        // uint highestAverageRating = 0;
        // uint winnerIndex;

        // for (uint i = 0; i < projects.length; i++) {
        //     uint sum = 0;
        //     for (uint j = 0; j < projects[i].ratings.length; j++) {
        //         sum += projects[i].ratings[j];
        //     }
        //     uint averageRating = sum / projects[i].ratings.length;

        //     if(averageRating > highestAverageRating) {
        //         highestAverageRating = averageRating;
        //         winnerIndex = i;
        //     }
        // }

        // return projects[winnerIndex];

        uint[] memory averageRatings = new uint[](projects.length);

        for (uint i = 0; i < projects.length; i++) {
            uint sum = 0;
            for (uint j = 0; j < projects[i].ratings.length; j++) {
                sum += projects[i].ratings[j];
            }
            averageRatings[i] = sum / projects[i].ratings.length;
        }

        uint winnerIndex = 0;
        for (uint i = 0; i < averageRatings.length; i++) {
            if(averageRatings[i] > averageRatings[winnerIndex]) {
                winnerIndex = i;
            }
        }

        return projects[winnerIndex];
    }

}