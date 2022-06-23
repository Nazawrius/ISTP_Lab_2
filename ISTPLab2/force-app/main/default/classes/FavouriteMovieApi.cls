@RestResource(urlMapping='/FavouriteMovie/*')
global with sharing class FavouriteMovieApi {
    @HttpGet
    global static Favourite_Movie__c getFavouriteMovie() {
        RestRequest request = RestContext.request;
        String requestURI = request.requestURI;
        Id favouriteMovieId = requestURI.substring(requestURI.lastIndexOf('/') + 1);
        return [
            SELECT Id, Movie__c, User__c, First_Watched__c
            FROM Favourite_Movie__c
            WHERE Id = :favouriteMovieId
        ];
    }

    @HttpPost
    global static Id postFavouriteMovie(Id movie, Id user, Date firstWatched) {
        Favourite_Movie__c favouriteMovie = new Favourite_Movie__c(
            Movie__c = movie,
            User__c = user,
            First_Watched__c = firstWatched
        );
        insert favouriteMovie;

        RestResponse response = RestContext.response;
        response.statusCode = 201;

        return favouriteMovie.Id;
    }

    @HttpPatch
    global static String patchFavouriteMovie(Id movie, Id user, Date firstWatched) {
        RestRequest request = RestContext.request;
        String requestURI = request.requestURI;
        Id favouriteMovieId = requestURI.substring(requestURI.lastIndexOf('/') + 1);
        Favourite_Movie__c favouriteMovie = [SELECT Id FROM Favourite_Movie__c WHERE Id = :favouriteMovieId];

        if(movie != null) {
            favouriteMovie.Movie__c = movie;
        }
        if(user != null) {
            favouriteMovie.User__c = user;
        }
        if(firstWatched != null) {
            favouriteMovie.First_Watched__c = firstWatched;
        }
       
        update favouriteMovie;
        return 'Updated succesfully!';
    }

    @HttpDelete
    global static void deleteFavouriteMovie() {
        RestRequest request = RestContext.request;
        String requestURI = request.requestURI;
        Id favouriteMovieId = requestURI.substring(requestURI.lastIndexOf('/') + 1);
        Favourite_Movie__c favouriteMovie = [SELECT Id FROM Favourite_Movie__c WHERE Id = :favouriteMovieId];
        delete favouriteMovie;
    }
}