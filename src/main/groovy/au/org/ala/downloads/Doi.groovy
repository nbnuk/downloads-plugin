package au.org.ala.downloads

import groovy.transform.Canonical

@Canonical
class Doi {
    Long id = 0

    String uuid
    String doi
    String title
    String authors
    String description
    List<String> licence
    Date dateMinted
    Provider provider
    String filename
    String contentType
    Long fileSize
    Byte[] fileHash

    Map<String, Object> providerMetadata
    Map<String, Object> applicationMetadata

    String customLandingPageUrl
    String applicationUrl

    Long version
    Date dateCreated
    Date lastUpdated

    enum Provider {
        ANDS
    }
}
