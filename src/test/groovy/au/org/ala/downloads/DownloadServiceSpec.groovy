package au.org.ala.downloads

import grails.test.mixin.TestFor
import grails.test.mixin.TestMixin
import grails.test.mixin.support.GrailsUnitTestMixin
import grails.test.mixin.web.InterceptorUnitTestMixin
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.services.ServiceUnitTestMixin} for usage instructions
 */
@TestFor(DownloadService)
@TestMixin([GrailsUnitTestMixin, InterceptorUnitTestMixin])
class DownloadServiceSpec extends Specification {

    def setup() {
    }

    def cleanup() {
    }

    void "test something"() {
    }
}
