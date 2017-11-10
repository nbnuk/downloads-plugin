package au.org.ala.downloads

import groovy.transform.SelfType

@SelfType(Iterable)
trait WithTotalCount {

    int totalCount

}