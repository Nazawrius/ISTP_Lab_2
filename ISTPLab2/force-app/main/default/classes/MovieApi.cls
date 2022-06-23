@RestResource(urlMapping='/Movie/*')
global with sharing class MovieApi {
    @HttpGet
    global static Movie__c getMovie() {
        RestRequest request = RestContext.request;
        String requestURI = request.requestURI;
        Id movieId = requestURI.substring(requestURI.lastIndexOf('/') + 1);
        return [
            SELECT Id, Name, Length__c, Release_Date__c, Synopsis__c, Box_Office__c, Budget__c
            FROM Movie__c
            WHERE Id = :movieId
        ];
    }

    @HttpPost
    global static Id postMovie(String name, String length, Date releaseDate, String synopsis, Integer boxOffice, Integer budget) {
        Movie__c movie = new Movie__c(
            Name = name,
            Length__c = length,
            Release_Date__c = releaseDate,
            Synopsis__c = synopsis,
            Box_Office__c = boxOffice,
            Budget__c = budget
        );
        insert movie;

        RestResponse response = RestContext.response;
        response.statusCode = 201;

        return movie.Id;
    }

    @HttpPatch
    global static String patchMovie(String name, String length, Date releaseDate, String synopsis, Integer boxOffice, Integer budget) {
        RestRequest request = RestContext.request;
        String requestURI = request.requestURI;
        Id movieId = requestURI.substring(requestURI.lastIndexOf('/') + 1);
        Movie__c movie = [SELECT Id FROM Movie__c WHERE Id = :movieId];

        if(name != null) {
            movie.Name = name;
        }
        if(length != null) {
            movie.Length__c = length;
        }
        if(releaseDate != null) {
            movie.Release_Date__c = releaseDate;
        }
        if(synopsis != null) {
            movie.Synopsis__c = synopsis;
        }
        if(boxOffice != null) {
            movie.Box_Office__c = boxOffice;
        }
        if(budget != null) {
            movie.Budget__c = budget;
        }
       
        update movie;
        return 'Updated succesfully!';
    }

    @HttpDelete
    global static void deleteMovie() {
        RestRequest request = RestContext.request;
        String requestURI = request.requestURI;
        Id movieId = requestURI.substring(requestURI.lastIndexOf('/') + 1);
        Movie__c movie = [SELECT Id FROM Movie__c WHERE Id = :movieId];
        delete movie;
    }
}
