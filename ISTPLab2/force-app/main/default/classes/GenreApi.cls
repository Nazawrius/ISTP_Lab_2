@RestResource(urlMapping='/Genre/*')
global with sharing class GenreApi {
    @HttpGet
    global static Genre__c getGenre() {
        RestRequest request = RestContext.request;
        String requestURI = request.requestURI;
        Id genreId = requestURI.substring(requestURI.lastIndexOf('/') + 1);
        return [
            SELECT Id, Name, Year_Of_Creation__c, Description__c
            FROM Genre__c
            WHERE Id = :genreId
        ];
    }

    @HttpPost
    global static Id postGenre(String name, Integer yearOfCreation, String description) {
        Genre__c genre = new Genre__c(
            Name = name,
            Year_Of_Creation__c = yearOfCreation,
            Description__c = description
        );
        insert genre;

        RestResponse response = RestContext.response;
        response.statusCode = 201;

        return genre.Id;
    }

    @HttpPatch
    global static String patchGenre(String name, Integer yearOfCreation, String description) {
        RestRequest request = RestContext.request;
        String requestURI = request.requestURI;
        Id genreId = requestURI.substring(requestURI.lastIndexOf('/') + 1);
        Genre__c genre = [SELECT Id FROM Genre__c WHERE Id = :genreId];

        if(name != null) {
            genre.Name = name;
        }
        if(yearOfCreation != null) {
            genre.Year_Of_Creation__c = yearOfCreation;
        }
        if(description != null) {
            genre.Description__c = description;
        }
       
        update genre;
        return 'Updated succesfully!';
    }

    @HttpDelete
    global static void deleteGenre() {
        RestRequest request = RestContext.request;
        String requestURI = request.requestURI;
        Id genreId = requestURI.substring(requestURI.lastIndexOf('/') + 1);
        Genre__c genre = [SELECT Id FROM Genre__c WHERE Id = :genreId];
        delete genre;
    }
}