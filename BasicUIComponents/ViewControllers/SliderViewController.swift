//
//  SliderViewController.swift
//  BasicUIComponents
//
//  Created by Burak on 17.09.2021.
//

import UIKit

class SliderViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    var sliderModelArray : [SliderModel] = []
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createInstancesOfSliderModel()
        configureFlowLayout()
        pageControl.numberOfPages = sliderModelArray.count
        pageControl.currentPage = 0
    }
    
    
    //MARK: - Helper Functions
    private func configureFlowLayout(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: collectionView.frame.size.height)
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        flowLayout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = flowLayout
    }
    
    private func createInstancesOfSliderModel(){
        sliderModelArray.append(SliderModel(title: "Pulp Fiction", image: UIImage(named: "pulp")!))
        sliderModelArray.append(SliderModel(title: "Kill Bill", image: UIImage(named: "kill")!))
        sliderModelArray.append(SliderModel(title: "Interstellar", image: UIImage(named: "interstellar")!))
        sliderModelArray.append(SliderModel(title: "The Dark Knight", image: UIImage(named: "batman")!))
        sliderModelArray.append(SliderModel(title: "Inception", image: UIImage(named: "inception")!))
    }
    
    
    @IBAction func changeSliderIndex(_ sender: UIPageControl) {
        collectionView.scrollToItem(at: [0, sender.currentPage], at: .right, animated: true)
    }
    
    
    
}


extension SliderViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


extension SliderViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sliderModelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControl.currentPage = indexPath.row
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        
        let pageFloat = (scrollView.contentOffset.x / scrollView.frame.size.width)
        
        if Float(pageFloat) > Float(sliderModelArray.count - 1) {
            collectionView.scrollToItem(at: [0,0], at: .right, animated: true)
        }
        else if Float(pageFloat) < 0 {
            collectionView.scrollToItem(at: [0, sliderModelArray.count - 1], at: .right, animated: true)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCollectionViewCell", for: indexPath) as! SliderCollectionViewCell
        cell.imageView.image = sliderModelArray[indexPath.row].image
        cell.titleLabel.text = sliderModelArray[indexPath.row].title
        return cell
    }
    
}
