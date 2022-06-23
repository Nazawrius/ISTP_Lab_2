@RestResource(urlMapping='/MovieGenre/*')
global with sharing class MovieGenreApi {
    @HttpGet
    global static Movie_Genre__c getMovieGenre() {
        RestRequest request = RestContext.request;
        String requestURI = request.requestURI;
        Id movieGenreId = requestURI.substring(requestURI.lastIndexOf('/') + 1);
        return [
            SELECT Id, Movie__c, Genre__c
            FROM Movie_Genre__c
            WHERE Id = :movieGenreId
        ];
    }

    @HttpPost
    global static Id postMovieGenre(Id movie, Id genre) {
        Movie_Genre__c movieGenre = new Movie_Genre__c(
            Movie__c = movie,
            Genre__c = genre
        );
        insert movieGenre;

        RestResponse response = RestContext.response;
        response.statusCode = 201;

        return movieGenre.Id;
    }

    @HttpPatch
    global static String patchMovieGenre(Id movie, Id genre) {
        RestRequest request = RestContext.request;
        String requestURI = request.requestURI;
        Id movieGenreId = requestURI.substring(requestURI.lastIndexOf('/') + 1);
        Movie_Genre__c movieGenre = [SELECT Id FROM Movie_Genre__c WHERE Id = :movieGenreId];

        if(movie != null) {
            movieGenre.Movie__c = movie;
        }
        if(genre != null) {
            movieGenre.Genre__c = genre;
        }
       
        update movieGenre;
        return 'Updated succesfully!';
    }

    @HttpDelete
    global static void deleteMovieGenre() {
        RestRequest request = RestContext.request;
        String requestURI = request.requestURI;
        Id movieGenreId = requestURI.substring(requestURI.lastIndexOf('/') + 1);
        Movie_Genre__c movieGenre = [SELECT Id FROM Movie_Genre__c WHERE Id = :movieGenreId];
        delete movieGenre;
    }
}