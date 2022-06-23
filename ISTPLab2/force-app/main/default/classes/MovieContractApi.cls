@RestResource(urlMapping='/MovieContract/*')
global with sharing class MovieContractApi {
    @HttpGet
    global static Movie_Contract__c getMovieContract() {
        RestRequest request = RestContext.request;
        String requestURI = request.requestURI;
        Id movieContractId = requestURI.substring(requestURI.lastIndexOf('/') + 1);
        return [
            SELECT Id, Movie__c, Actor__c, Role__c
            FROM Movie_Contract__c
            WHERE Id = :movieContractId
        ];
    }

    @HttpPost
    global static Id postMovieContract(Id movie, Id actor, String role) {
        Movie_Contract__c movieContract = new Movie_Contract__c(
            Movie__c = movie,
            Actor__c = actor,
            Role__c = role
        );
        insert movieContract;

        RestResponse response = RestContext.response;
        response.statusCode = 201;

        return movieContract.Id;
    }

    @HttpPatch
    global static String patchMovieContract(Id movie, Id actor, String role) {
        RestRequest request = RestContext.request;
        String requestURI = request.requestURI;
        Id movieContractId = requestURI.substring(requestURI.lastIndexOf('/') + 1);
        Movie_Contract__c movieContract = [SELECT Id FROM Movie_Contract__c WHERE Id = :movieContractId];

        if(movie != null) {
            movieContract.Movie__c = movie;
        }
        if(actor != null) {
            movieContract.Actor__c = actor;
        }
        if(role != null) {
            movieContract.Role__c = role;
        }
       
        update movieContract;
        return 'Updated succesfully!';
    }

    @HttpDelete
    global static void deleteMovieContract() {
        RestRequest request = RestContext.request;
        String requestURI = request.requestURI;
        Id movieContractId = requestURI.substring(requestURI.lastIndexOf('/') + 1);
        Movie_Contract__c movieContract = [SELECT Id FROM Movie_Contract__c WHERE Id = :movieContractId];
        delete movieContract;
    }
}