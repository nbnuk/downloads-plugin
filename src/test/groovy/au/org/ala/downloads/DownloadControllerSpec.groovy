package au.org.ala.downloads

import grails.test.mixin.TestFor
import grails.test.mixin.TestMixin
import grails.test.mixin.support.GrailsUnitTestMixin
import grails.test.mixin.web.InterceptorUnitTestMixin
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.web.ControllerUnitTestMixin} for usage instructions
 */
@TestFor(DownloadController)
@TestMixin([GrailsUnitTestMixin, InterceptorUnitTestMixin])
class DownloadControllerSpec extends Specification {

    def setup() {
    }

    def cleanup() {
    }

    void "test something"() {
        when:
        def a = 1+2
        then:
        //pass
        a == 3
    }
}
