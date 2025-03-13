function deletePost(no) {
    if (confirm('정말로 삭제하시겠습니까?')) {
        // DELETE 요청으로 데이터를 보냄
        fetch('/main/free/' + no, {
            method: 'DELETE',  // HTTP method를 DELETE로 설정
            headers: {
                'Content-Type': 'application/json',  // JSON 형식으로 데이터 전송
            }
        })
            .then(response => response.json())  // 서버에서 응답을 JSON 형태로 받음
            .then(data => {
                alert('삭제 되었습니다.');
                location.href = '/main/free';  // 삭제 후 페이지를 리다이렉트
            })
            .catch(error => {
                console.error('Error:', error);  // 에러 처리
            });
    }
}


