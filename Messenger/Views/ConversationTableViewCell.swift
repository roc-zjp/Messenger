//
//  ConversationTableViewCell.swift
//  Messenger
//
//  Created by zjp on 2021/11/19.
//

import UIKit
import SDWebImage

class ConversationTableViewCell: UITableViewCell {
    
    public static let identifire = "ConversationTableViewCell"
    
    private let userImageView :UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 50
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let userNameLabel :UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 21,weight:.semibold)
        label.numberOfLines = 1
        return label
    }()
    
    private let userMessageLabel :UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19,weight:.regular)
        label.numberOfLines = 2
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(userImageView)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(userMessageLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        userImageView.frame = CGRect(x: 10,
                                     y: 10,
                                     width: 100,
                                     height: 100)
        
        userNameLabel.frame = CGRect(x: userImageView.right + 10,
                                     y: 10,
                                     width: contentView.width - 20 - userImageView.width,
                                     height: (contentView.height - 20)/2)
        
        userMessageLabel.frame = CGRect(x:  userImageView.right + 10,
                                        y:  userNameLabel.bottom + 10,
                                        width: contentView.width - 20 - userImageView.width,
                                        height: (contentView.height - 20)/2)
        
    }
    
    public func configure(with model:Conversation) {
        userNameLabel.text = model.name
        userMessageLabel.text = model.lastMessage.message
        let path = "images/\(model.otherUserEmail)_profile_picture.png"
        StorageManager.shared.downloadUrl(for: path, completion: {[weak self] result  in
            switch result{
            case .success(let url):
                DispatchQueue.main.async {
                    self?.userImageView.sd_setImage(with: url, completed: nil)
                }
            case .failure(let error):
                print("failed to get download url:\(error)")
            }
        })
    }
}
