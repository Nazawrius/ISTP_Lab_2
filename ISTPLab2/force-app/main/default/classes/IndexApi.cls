@RestResource(urlMapping='/')
global with sharing class IndexApi {
    @HttpGet
    global static String getIndex() {
        return 'Welcome to index page! You can create, view, edit and delete records by going to the corresponding endpoints';
    }
}