
import Foundation
import UIKit

extension SettingsVC {

    func setUserProfile() {
        setStackView()
    }
    
    /* stackView 설정하기 */
    func setStackView() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        setProfilePictureView()
        setNickNameLabel()
    }
    
    /* 사진 불러와서 stackView에 붙이기 */
    func setProfilePictureView() {
        profilePicture = setProfilePicture()
        profilePictureView.contentMode = .scaleAspectFit
        profilePictureView.image = profilePicture
        profilePictureView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profilePictureView.heightAnchor.constraint(lessThanOrEqualToConstant: 50),
            profilePictureView.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        stackView.addArrangedSubview(profilePictureView)
    }
    
    /* 닉네임 불러와서 stackView에 붙이기 */
    func setNickNameLabel() {
        nickName = setNickName()
        nickNameLabel.text = nickName
        nickNameLabel.font = .boldSystemFont(ofSize: 30)
        nickNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(nickNameLabel)
    }
    
    /* 닉네임 불러오기 */
    func setNickName() -> String {
        guard let nickName = UserDefaults.standard.string(forKey: "nickName")  else {
            print("닉네임이 없습니다")
            return "No Nickname"
        }
        print("닉네임 로드 성공", nickName)
        return nickName
    }
    
    /* 프로필 사진 불러오기 */
    func setProfilePicture() -> UIImage {
        guard let profilePicture = UserDefaults.standard.data(forKey: "profilePicture") else {
            print("이미지가 없습니다")
            return UIImage(systemName: "person.crop.circle")!
        }
        return UIImage(data: profilePicture)!
    }
}
