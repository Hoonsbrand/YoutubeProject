# About

  
![](https://s3.us-west-2.amazonaws.com/secure.notion-static.com/e7ca1581-f36b-4be7-b422-63e7654d7a61/images_tsts__post_909df88a-017e-498c-aaa0-a9dcd57fb614_image.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20230210%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20230210T025302Z&X-Amz-Expires=86400&X-Amz-Signature=14acac4e29696ff202ff371e21151deda3ee19dc7945b4a7287c740401f32d77&X-Amz-SignedHeaders=host&response-content-disposition=filename%3D%22images_tsts__post_909df88a-017e-498c-aaa0-a9dcd57fb614_image.png%22&x-id=GetObject)

Udemy Angela Yu의 강의 이후 앨런의 문법 강의를 수강하면서 약 3~4개월 정도 네트워크를 이용한 프로젝트를 접하지 못해서 시작하게 된 프로젝트이다.

네트워크 통신을 할 때 대표적으로 많이 쓰이는 Alamofire를 사용해보기전에 간단히 URL Session을 되짚고 넘어가자는 마음에 시작하였다.

URL Session을 이용해 네트워크 통신을 하는 간단한 앱을 만들고 싶어서 API를 찾던 도중 세계 최대 규모의 동양상 공유 및 호스팅 업체인 YouTube의 API를 발견하여 만들게 되었다.

`YouTube Data API v3`  를 통해 국내에서 실시간으로 가장 인기있는 동영상들을 25개씩 보여준다.

----------

# 메인 화면

  
![](https://s3.us-west-2.amazonaws.com/secure.notion-static.com/c13ad6a9-94be-4335-b190-f96b1e894fdc/Untitled.gif?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20230210%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20230210T025316Z&X-Amz-Expires=86400&X-Amz-Signature=d0245299fb5f5a71fa994d9f3c5d6da4ca358e032c6c335f762193410d06cc35&X-Amz-SignedHeaders=host&response-content-disposition=filename%3D%22Untitled.gif%22&x-id=GetObject)

`YouTube Data API`  는 maxResults라는 파라미터를 통해 몇개의 결과를 보여줄 것인지 설정할 수 있다.

여기서는 25개로 설정을 했다.

# 동영상 재생

  
![](https://s3.us-west-2.amazonaws.com/secure.notion-static.com/380843d7-2970-4c95-98b9-81ac45943729/Untitled.gif?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20230210%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20230210T025341Z&X-Amz-Expires=86400&X-Amz-Signature=83357810b0478d37a265546c3c10311c4beb2feb1e4ed0b73b2f368b19fc2990&X-Amz-SignedHeaders=host&response-content-disposition=filename%3D%22Untitled.gif%22&x-id=GetObject)

해당 영상을 누르면

`YouTubePlayer_in_WKWebView`  라이브러리를 통해 해당 영상의 id를 넘겨주어 id에 맞는 영상을 불러와준다.

# 새로고침

 
![](https://s3.us-west-2.amazonaws.com/secure.notion-static.com/4adcbb91-4f50-4b95-8a37-f642a3b7439b/Untitled.gif?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20230210%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20230210T025434Z&X-Amz-Expires=86400&X-Amz-Signature=96d08a927045670a31d08bad3f5c232e5866aa8b8ba207abc6ebbed8872420e5&X-Amz-SignedHeaders=host&response-content-disposition=filename%3D%22Untitled.gif%22&x-id=GetObject)

뷰의 최상단에서 당기는 동작을 하면 다음 영상들을 불러와준다.

`YouTube Data API`  의 응답으로 nextPageToken이라는 다음 페이지의 토큰값을 받을 수 있는데 이를

파라미터 pageToken에 넣어주면 해당 토큰과 일치하는 페이지를 받아볼 수 있다.

정리해보자면,

1.  처음 화면은 특정 페이지가 아니다. 그래서 호출할 때 분기처리를 해서 미리 만들어놓은 pageToken이 nil일 때 pageToken 파라미터를 사용하지 않는다. 그 후 다음 페이지에 대한 정보가 있는 nextPageToken을 받는다. 이것을 pageToken변수에 저장한다.
2.  뷰를 당긴다.
3.  뷰를 당기면 다시한번 호출이 이루어지는데 이 과정에서 분기처리를 할 때 pageToken에 값이 있으므로 pageToken파라미터에 해당 변수를 넣은 URL로 호출을 한다. 그럼 다시 다음 페이지에 대한 정보가 있는 nextPageToken을 받아서 pageToken변수에 저장하며 이를 반복한다.

----------

# 🌟 Learned

URLSession에 대해 복습할 수 있었다.

해당 API 문서를 잘 살펴보면 호출할 수 있는 데이터들이 잘 나와있다는 걸 깨달았다.

