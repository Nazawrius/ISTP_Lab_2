@RestResource(urlMapping='/Actor/*')
global with sharing class ActorApi {
    @HttpGet
    global static Actor__c getActor() {
        RestRequest request = RestContext.request;
        String requestURI = request.requestURI;
        Id actorId = requestURI.substring(requestURI.lastIndexOf('/') + 1);
        return [
            SELECT Id, Name, Gender__c, Birth_Date__c, Birth_Place__c, Biography__c
            FROM Actor__c
            WHERE Id = :actorId
        ];
    }

    @HttpPost
    global static Id postActor(String name, String gender, Date birthDate, String birthPlace, String biography) {
        Actor__c actor = new Actor__c(
            Name = name,
            Gender__c = gender,
            Birth_Date__c = birthDate,
            Birth_Place__c = birthPlace,
            Biography__c = biography
        );
        insert actor;

        RestResponse response = RestContext.response;
        response.statusCode = 201;
        
        return actor.Id;
    }

    @HttpPatch
    global static String patchActor(String name, String gender, Date birthDate, String birthPlace, String biography) {
        RestRequest request = RestContext.request;
        String requestURI = request.requestURI;
        Id actorId = requestURI.substring(requestURI.lastIndexOf('/') + 1);
        Actor__c actor = [SELECT Id FROM Actor__c WHERE Id = :actorId];

        if(name != null) {
            actor.Name = name;
        }
        if(gender != null) {
            actor.Gender__c = gender;
        }
        if(birthDate != null) {
            actor.Birth_Date__c = birthDate;
        }
        if(birthPlace != null) {
            actor.Birth_Place__c = birthPlace;
        }
        if(biography != null) {
            actor.Biography__c = biography;
        }
       
        update actor;
        return 'Updated succesfully!';
    }

    @HttpDelete
    global static void deleteActor() {
        RestRequest request = RestContext.request;
        String requestURI = request.requestURI;
        Id actorId = requestURI.substring(requestURI.lastIndexOf('/') + 1);
        Actor__c actor = [SELECT Id FROM Actor__c WHERE Id = :actorId];
        delete actor;
    }
}
