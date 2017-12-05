package au.org.ala.downloads

import com.squareup.moshi.Moshi
import com.squareup.moshi.Rfc3339DateJsonAdapter
import grails.gorm.PagedResultList
import okhttp3.Interceptor
import okhttp3.OkHttpClient
import okhttp3.Response
import org.springframework.beans.factory.annotation.Value
import retrofit2.Retrofit
import retrofit2.converter.moshi.MoshiConverterFactory
import okhttp3.logging.HttpLoggingInterceptor
import javax.annotation.PostConstruct

class DoiService {

    def grailsApplication

    @Value('${doiService.baseUrl}')
    String doiServiceBaseUrl

    @Value('${webservice.apiKeyHeader:apiKey}')
    String apiKeyHeader

    @Value('${webservice.apikey}')
    String apiKey

    DoiClient doiClient

    @PostConstruct
    def init() {
        def logging = new HttpLoggingInterceptor()

        logging.level = HttpLoggingInterceptor.Level.BODY


        def client = new OkHttpClient.Builder().addInterceptor(new Interceptor() {
            @Override
            Response intercept(Interceptor.Chain chain) throws IOException {
                def request = chain.request()
                def builder = request.newBuilder()
                if (request.method() != 'GET') builder.addHeader(apiKeyHeader, apiKey)
                def newRequest = builder.addHeader('Accept', 'application/json').build()
                return chain.proceed(newRequest)
            }
        }).addInterceptor(logging).build()


        def moshi = new Moshi.Builder().add(Date, new Rfc3339DateJsonAdapter().nullSafe()).build()

        def retrofit = new Retrofit.Builder().baseUrl(doiServiceBaseUrl).client(client).addConverterFactory(MoshiConverterFactory.create(moshi)).build()
        doiClient = retrofit.create(DoiClient)
    }

    def listDownloadsDoi(String userId, String sortColumn = "dateMinted", String order = "desc", Integer offset = 0, Integer max = 10) {
        def response = doiClient.list(max, offset, sortColumn, order, userId).execute()
        if (response.isSuccessful()) {
            def totalCount = response.headers()['X-Total-Count']?.toInteger() ?: 0
            def doiList = response.body().withTraits(WithTotalCount)
            doiList.totalCount = totalCount
            return doiList
        } else {
            throw new DoiServiceException("Got ${response.code()} from DOI List service")
        }
    }

    def getDoi(String doi = null) {
        def result
        if (doi) {
            def response = doiClient.get(doi).execute()
            if (response.isSuccessful()) {
                result = response.body()
            } else {
                throw new DoiServiceException("Got ${response.code()} for $doi from DOI get service")
            }
        }
        return result
    }

}
