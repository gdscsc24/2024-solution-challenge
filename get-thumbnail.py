import pandas as pd

file_path = r'C:\Users\user\Downloads\2024 솔챌\유투브영상수집.xlsx'
df = pd.read_excel(file_path)

df['이미지 주소'] = ''

for index, row in df.iterrows():
    youtube_video_url = row['링크']
    # 문자열 타입 확인 및 처리
    if isinstance(youtube_video_url, str):
        # 동영상 ID 추출 로직
        if "youtu.be" in youtube_video_url:
            video_id = youtube_video_url.split("youtu.be/")[1].split("?")[0]
        else:
            video_id = youtube_video_url.split("v=")[-1].split("&")[0]
        # 썸네일 이미지 주소 생성
        thumbnail_url = f"https://img.youtube.com/vi/{video_id}/maxresdefault.jpg"
    else:
        # 유효하지 않은 링크 처리 (빈 문자열로 설정)
        thumbnail_url = ""
    # 데이터프레임 업데이트
    df.at[index, '이미지 주소'] = thumbnail_url

# 수정된 데이터프레임을 새로운 엑셀 파일로 저장
new_file_path = r'C:\Users\user\Downloads\2024 솔챌\유투브영상수집_썸네일추가.xlsx'
df.to_excel(new_file_path, index=False)

new_file_path
