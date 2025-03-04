const axios = require('axios');
const serviceKey = 'bOkfjhsZtYm6mTldXCqmQERqAnoAf86Rz1in%2BTo4oJu5EoNDcWfR0LjGf15Z1Z6bcQS7xtAwecqLEHJhiIDcTw%3D%3D'; // 발급받은 API 키 입력

const url = 'http://apis.data.go.kr/B551011/JpnService1/areaBasedList1'; // 일본어 관광 정보 API
const params = {
    serviceKey: serviceKey,
    numOfRows: 10,      // 한 번에 가져올 데이터 개수
    pageNo: 1,          // 페이지 번호
    MobileOS: 'ETC',    // OS 종류 (고정값)
    MobileApp: 'YourAppName', // 앱 이름 (아무거나 가능)
    arrange: 'A',       // 정렬 기준 (A: 제목순)
    contentTypeId: 12,  // 관광지 (12)
    areaCode: 1,        // 서울특별시 (1)
    _type: 'json'       // JSON 응답 요청
};

axios.get(url, { params })
    .then(response => {
        console.log(response.data);
    })
    .catch(error => {
        console.error('데이터 요청 중 오류 발생:', error);
    });
