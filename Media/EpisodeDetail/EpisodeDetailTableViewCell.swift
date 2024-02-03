//
//  EpisodeDetailTableViewCell.swift
//  Media
//
//  Created by 민지은 on 2024/02/04.
//

import UIKit

class EpisodeDetailTableViewCell: UITableViewCell {
    
    let stillImage = UIImageView()
    let playButton = UIButton()
    let episodeTitle = UILabel()
    var overView = UILabel()
    let timeLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureHierarchy() {
        contentView.addSubview(stillImage)
        stillImage.addSubview(playButton)
        contentView.addSubview(episodeTitle)
        contentView.addSubview(overView)
        contentView.addSubview(timeLabel)
    }
    
    func configureLayout() {
        stillImage.snp.makeConstraints { make in
            make.top.leading.equalTo(15)
            make.bottom.equalTo(self).inset(30)
            make.width.equalTo(140)
        }
        
        playButton.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.size.equalTo(30)
        }
        
        episodeTitle.snp.makeConstraints { make in
            make.leading.equalTo(stillImage.snp.trailing).offset(15)
            make.top.equalTo(stillImage)
            make.trailing.lessThanOrEqualTo(-15)
        }
        
        overView.snp.makeConstraints { make in
            make.top.equalTo(episodeTitle.snp.bottom).offset(5)
            make.leading.trailing.equalTo(episodeTitle)
            make.height.lessThanOrEqualTo(70)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(overView.snp.bottom).offset(4)
            make.leading.equalTo(episodeTitle)
            make.bottom.lessThanOrEqualTo(self).inset(8)
        }
       
        
    }
    
    func configureView() {
        stillImage.backgroundColor = .systemPink
        stillImage.clipsToBounds = true
        stillImage.layer.cornerRadius = 10
        playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        playButton.backgroundColor = .black.withAlphaComponent(0.6)
        playButton.clipsToBounds = true
        playButton.layer.borderWidth = 1
        playButton.layer.borderColor = UIColor.white.cgColor
        playButton.layer.cornerRadius = 15
        playButton.tintColor = .white
        episodeTitle.text = "1화: 세상이 그댈 속일지라도"
        episodeTitle.font = .systemFont(ofSize: 14, weight: .semibold)
        episodeTitle.textColor = .white
        overView.text = "터너의 그림 라이헨바흐 폭포 도난사건을 해결한 셜록은 라이헨바흐의 영웅이란 별명을 얻으며 인기 탐정이 된다. 밀려드는 사건 의뢰에 바쁜 나날을 보내던 그에게 어느 날, 숙적 모리아티가 돌아왔다는 소식이 전해진다. 대담한 범죄로 세상을 떠들썩하게 만든 모리아티는 셜록에게 두 사람 사이의 마지막 문제를 풀 때가 왔다며 도전장을 던진다."
        overView.font = .systemFont(ofSize: 13, weight: .semibold)
        overView.textColor = .lightGray
        overView.numberOfLines = 0
        timeLabel.text = "89분"
        timeLabel.font = .systemFont(ofSize: 13, weight: .medium)
        timeLabel.textColor = .gray
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}


#Preview {
    EpisodeDetailViewController()
}
