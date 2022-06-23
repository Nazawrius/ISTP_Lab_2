@RestResource(urlMapping='/User/*')
global with sharing class UserApi {
    @HttpGet
    global static User__c getUser() {
        RestRequest request = RestContext.request;
        String requestURI = request.requestURI;
        Id userId = requestURI.substring(requestURI.lastIndexOf('/') + 1);
        return [
            SELECT Id, Name, Gender__c, Email__c, Age__c
            FROM User__c
            WHERE Id = :userId
        ];
    }

    @HttpPost
    global static Id postUser(String name, String gender, String email, Integer age) {
        User__c user = new User__c(
            Name = name,
            Gender__c = gender,
            Email__c = email,
            Age__c = age
        );
        insert user;

        RestResponse response = RestContext.response;
        response.statusCode = 201;

        return user.Id;
    }

    @HttpPatch
    global static String patchUser(String name, String gender, String email, Integer age) {
        RestRequest request = RestContext.request;
        String requestURI = request.requestURI;
        Id userId = requestURI.substring(requestURI.lastIndexOf('/') + 1);
        User__c user = [SELECT Id FROM User__c WHERE Id = :userId];

        if(name != null) {
            user.Name = name;
        }
        if(gender != null) {
            user.Gender__c = gender;
        }
        if(email != null) {
            user.Email__c = email;
        }
        if(age != null) {
            user.Age__c = age;
        }
       
        update user;
        return 'Updated succesfully!';
    }

    @HttpDelete
    global static void deleteUser() {
        RestRequest request = RestContext.request;
        String requestURI = request.requestURI;
        Id userId = requestURI.substring(requestURI.lastIndexOf('/') + 1);
        User__c user = [SELECT Id FROM User__c WHERE Id = :userId];
        delete user;
    }
}