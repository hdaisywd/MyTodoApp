
import Foundation
import UIKit

extension SettingsVC {
    
    func setUserProfile() {
        setUserProfileView() 
        setUserProfileStackView()
    }
    
    /* 테두리 설정 */
    func setUserProfileView() {
        view.addSubview(userProfileView)
        
        userProfileView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            userProfileView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            userProfileView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            userProfileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            userProfileView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    /* User Profile StackView 설정하기 */
    func setUserProfileStackView() {
        userProfileView.addSubview(userProfileStackView)
        
        userProfileStackView.translatesAutoresizingMaskIntoConstraints = false
        userProfileStackView.axis = .horizontal
        userProfileStackView.distribution = .fill
        userProfileStackView.alignment = .fill
        userProfileStackView.spacing = 10

        NSLayoutConstraint.activate([
            userProfileStackView.leadingAnchor.constraint(equalTo: userProfileView.leadingAnchor, constant: 10),
            userProfileStackView.trailingAnchor.constraint(equalTo: userProfileView.trailingAnchor, constant: -10),
            userProfileStackView.topAnchor.constraint(equalTo: userProfileView.topAnchor, constant: 10),
            userProfileStackView.bottomAnchor.constraint(lessThanOrEqualTo: userProfileView.bottomAnchor)
        ])
        
        setProfilePictureView()
        setNickNameLabel()
    }
    
    /* 사진 불러와서 stackView에 붙이기 */
    /* 이게 왜 됨? */
    func setProfilePictureView() {
        profilePicture = setProfilePicture()
        profilePictureView.contentMode = .scaleAspectFit
        profilePictureView.image = profilePicture
        profilePictureView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profilePictureView.heightAnchor.constraint(lessThanOrEqualToConstant: 50),
            profilePictureView.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        userProfileStackView.addArrangedSubview(profilePictureView)
    }
    
    /* 닉네임 불러와서 stackView에 붙이기 */
    func setNickNameLabel() {
        nickName = setNickName()
        nickNameLabel.text = nickName
        nickNameLabel.font = .boldSystemFont(ofSize: 25)
        nickNameLabel.textColor = .white
        nickNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        userProfileStackView.addArrangedSubview(nickNameLabel)
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
            return UIImage(systemName: "person.crop.circle")!.withTintColor(UIColor.systemTeal, renderingMode: .alwaysOriginal)
        }
        return UIImage(data: profilePicture)!
    }
}
