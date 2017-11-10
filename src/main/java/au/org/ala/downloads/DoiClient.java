package au.org.ala.downloads;

import okhttp3.ResponseBody;
import retrofit2.Call;
import retrofit2.http.*;

import java.util.List;

public interface DoiClient {

    @Headers("Accept-Version: 1.0")
    @GET("doi")
    Call<List<Doi>> list(@Query("max") Integer max, @Query("offset") Integer offset, @Query("sort") String sort, @Query("order") String order, @Query("userId") String userId);

    @Headers("Accept-Version: 1.0")
    @GET("doi/{doi}")
    Call<Doi> get(@Path("doi") String doi);
    @Headers("Accept-Version: 1.0")
    @GET("doi/{doi}")
    Call<Doi> getEncoded(@Path(value = "doi", encoded = true) String doi);

    @Headers("Accept-Version: 1.0")
    @GET("doi/{doi}/download")
    Call<ResponseBody> download(@Path("doi") String doi);
    @Headers("Accept-Version: 1.0")
    @GET("doi/{doi}/download")
    Call<ResponseBody> downloadEncoded(@Path(value = "doi", encoded = true) String doi);

}
