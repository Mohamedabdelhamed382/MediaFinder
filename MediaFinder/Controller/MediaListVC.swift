//
//  MyTabelViewController.swift
//  TableViewDemo
//
//  Created by Mohamed Abdelhamed Ahmed on 12/24/20.
//  Copyright © 2020 IDE Academy. All rights reserved.
//
import UIKit
import AVKit
import AVFoundation

class MyTableVC: UIViewController  {
    //MARK:- Outlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mediaTypeSearch: UISegmentedControl!
    @IBOutlet weak var searchAleartView: UIView!
    //MARK:- Properties
    var activatyIndector = UIActivityIndicatorView()
    var searching = false
    var mediaArr: [Media] = [Media]()
    var mediaTypeDefulat: MediaType!
    //MARK:- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hello")
        print("hello")
        UserDefaults.standard.setValue(true, forKey: UserDefaultsKeys.isLoged)
        getMediaDataType()
        print( mediaTypeDefulat.rawValue)
        print(getMediaDataType())
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        SqlLiteManger.shared().createTabelSearch()
        oldDataSearch()
        print(mediaTypeDefulat)
        print(SqlLiteManger.shared().getDataSearch()?.count)
        tableView.register(UINib(nibName: cells.mediaCell, bundle: nil), forCellReuseIdentifier:  cells.mediaCell)
        let proFileBtn = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(gotoProfile))
        self.navigationItem.rightBarButtonItem = proFileBtn
    }
    
    override func viewWillAppear(_ animated: Bool){
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationItem.setHidesBackButton(false , animated: true)
        UserDefaults.standard.setValue(mediaTypeDefulat.rawValue, forKey: "typeData")
        
    }
    //MARK:- Action
    @objc func gotoProfile() {
        gotoProfileVC()
    }
    
    @IBAction func searchTypeSegmented(_ sender: UISegmentedControl)
    {
        switch sender.selectedSegmentIndex
        {
        case 0:
            self.mediaTypeDefulat = .music
        case 1:
            mediaTypeDefulat = .movie
        case 2:
            mediaTypeDefulat = .tvShow
        default:
            mediaTypeDefulat = .music
        }
        guard let searchText = searchBar.text, searchText != "" else {
            return
        }
        bindData(searchText: searchText, mediaType: mediaTypeDefulat.rawValue )
    }
}
//MARK:- Tabel View Function
extension MyTableVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.view.isUserInteractionEnabled = false
        let cell = tableView.dequeueReusableCell(withIdentifier: cells.mediaCell,for:indexPath)as! MediaCell
        cell.configure(mediaType: self.mediaTypeDefulat , media: mediaArr[indexPath.row])
        self.view.isUserInteractionEnabled = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        playVideo(vidoName: mediaArr[indexPath.row].previewUrl)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 341
    }
}
//MARK:- SearchBar
extension MyTableVC : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searching = true
        bindData(searchText: searchText, mediaType: mediaTypeDefulat.rawValue)
        if searchBar.text != ""{
            self.searchAleartView.isHidden = true
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        self.searchAleartView.isHidden = false
        self.tableView.reloadData()
    }
    
}
// MARK:- private Function
extension MyTableVC {
    private func playVideo(vidoName: String) {
        let videoURL = URL(string: vidoName)
        let player = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
    private func getMediaDataType(){
        if let iconSizeRawValue = UserDefaults.standard.object(forKey: "iconSize") as? String {
            self.mediaTypeDefulat = MediaType(rawValue: iconSizeRawValue)!
            switch mediaTypeDefulat.rawValue {
            case "movie":
                mediaTypeSearch.selectedSegmentIndex = 1
            case "tvShow":
                mediaTypeSearch.selectedSegmentIndex = 2
            default:
                mediaTypeSearch.selectedSegmentIndex = 0
            }
        }else{
            self.mediaTypeDefulat = .music
        }
    }
    private func storMediaDataType(){
        let defaults = UserDefaults.standard
        defaults.set(mediaTypeDefulat.rawValue, forKey: "iconSize")
    }
    private func bindData(searchText: String ,mediaType : String ){
        APIManager.loadMedia(searchQuery: searchText, mediaType: mediaType){
            (error, myMediaArr) in
            if let error = error {
                self.alert(title: "error", message: error.localizedDescription)
            } else if let myMediaArr = myMediaArr {
                //when no error and completion done
                self.mediaArr = myMediaArr
                self.tableView.reloadData()
            }
            SqlLiteManger.shared().deleteLastSearch()
            SqlLiteManger.shared().insertSearch(userSearch: self.mediaArr)
            self.storMediaDataType()
            if self.searchBar.text == ""{
                self.searchAleartView.isHidden = false
            }
        }
    }
    private  func gotoProfileVC(){
        let sb = UIStoryboard(name: Storybord.main, bundle: nil)
        let ProfileVC = sb.instantiateViewController(withIdentifier: ViewContllor.profileVC)as! ProfileVC
        self.navigationController?.pushViewController(ProfileVC, animated: true)
    }
    private func oldDataSearch(){
        if let count = SqlLiteManger.shared().getDataSearch()?.count{
            if count > 0 {
                self.searchAleartView.isHidden = true
                self.mediaArr = SqlLiteManger.shared().getDataSearch()!
                self.tableView.reloadData()
            }
        }
    }
}
