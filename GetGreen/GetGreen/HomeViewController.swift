//
//  HomeViewController.swift
//  GetGreen
//
//  Created by Annie Tung on 6/24/17.
//  Copyright © 2017 Liam Kane. All rights reserved.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var getGreenLabel: UILabel!
    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getGreenLabel.text = "GetGreen"
        welcomeLabel.text = "Hey Bean, \n How you been?"
        logoImage.image = UIImage(named: "logo")
        setupViewHierarcy()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Set up view hierarchy
    
    func setupViewHierarcy() {
        self.view.addSubview(menuView)
        self.view.addSubview(findGardenButton)
        self.view.addSubview(greenFactsButton)
        self.view.addSubview(projectsButton)
        self.view.addSubview(connectButton)
        menuView.snp.makeConstraints { (view) in
            view.top.bottom.equalToSuperview()
            view.right.equalTo(self.view.snp.left)
            view.width.equalTo(self.view).multipliedBy(0.5)
        }
        findGardenButton.snp.makeConstraints({ (view) in
            view.top.equalToSuperview().inset(30)
            view.centerX.equalTo(menuView.snp.centerX)
        })
        greenFactsButton.snp.makeConstraints({ (view) in
            view.top.equalTo(findGardenButton.snp.bottom).offset(30)
            view.centerX.equalTo(menuView.snp.centerX)
        })
        projectsButton.snp.makeConstraints({ (view) in
            view.top.equalTo(greenFactsButton.snp.bottom).offset(30)
            view.centerX.equalTo(menuView.snp.centerX)
        })
        connectButton.snp.makeConstraints({ (view) in
            view.top.equalTo(projectsButton.snp.bottom).offset(30)
            view.centerX.equalTo(menuView.snp.centerX)
        })
    }
    
    // MARK: - Methods
    
    @IBAction func menuButtonPressed(_ sender: UIButton) {
        animateMenuViewIn()
    }
    
    func animateMenuViewIn() {
        let animator = UIViewPropertyAnimator(duration: 0.5, curve: .linear) {
            self.menuView.snp.remakeConstraints { (view) in
                view.top.bottom.equalToSuperview()
                view.right.equalTo(self.view.snp.centerX)
                view.width.equalTo(self.view).multipliedBy(0.5)
            }
            self.logoImage.snp.remakeConstraints({ (view) in
                view.right.equalToSuperview()
                view.left.equalTo(self.view.snp.centerX)
            })
            self.getGreenLabel.alpha = 0
            self.welcomeLabel.alpha = 0
            self.view.layoutIfNeeded()
        }
        animator.startAnimation()
    }
    
    func findGardenPressed() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let svc = storyboard.instantiateViewController(withIdentifier: "showMap")
        self.present(svc, animated: true, completion: nil)
    }
    
    func greenFactsPressed() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let svc = storyboard.instantiateViewController(withIdentifier: "showFacts")
        self.present(svc, animated: true, completion: nil)
    }
    
    func projectsPressed() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let svc = storyboard.instantiateViewController(withIdentifier: "showProjects")
        self.present(svc, animated: true, completion: nil)
    }
    
    func connectPressed() {
        
    }
    
    lazy var menuView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    lazy var findGardenButton: UIButton = {
        let button = UIButton()
        button.setTitle("Find Garden", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(findGardenPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var greenFactsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Green Facts", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(greenFactsPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var projectsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Projects", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(projectsPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var connectButton: UIButton = {
        let button = UIButton()
        button.setTitle("Connect", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(connectPressed), for: .touchUpInside)
        return button
    }()

    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
