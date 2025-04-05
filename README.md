# employee_data

An app to list and do all other crud operations to maintain the employee data.

## Architecture:-
Clean Architecture: I have used clean architecture in this project. The reason for choosing clean architecture is to make the project flexible and easy for future development. Each folder has separate responsibility which allow us to make changes to minimal number of files/folders.
For example: if in future we have to fetch and update the data on remote servers as well then we only need to make changes to repository and datasource folders. Also this architecture would help us to follow the 'separation of concern' principle.

## NOTES
- For job role right now I have used enum instead of enity because in current scenario it is more efficient as we don't have to read the data from local database and enum data are also constants
