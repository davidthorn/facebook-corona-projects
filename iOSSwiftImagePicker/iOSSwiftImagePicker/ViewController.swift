//
//  ViewController.swift
//  iOSSwiftImagePicker
//
//  Created by David Thorn on 23.03.20.
//  Copyright © 2020 David Thorn. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    private lazy var addIconBarButton: UIBarButtonItem = {
        UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openImagePicker))
    }()

    private lazy var removeIconBarButton: UIBarButtonItem = {
        UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(removeImage))
    }()


    private var imagePicker: UIImagePickerController?

    private let imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Image Picker"


        view.addSubview(imageView)
        imageView.frame = view.bounds
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageView.contentMode = .scaleAspectFit

        navigationItem.setRightBarButtonItems([addIconBarButton], animated: true)

    }

    @objc private func removeImage() {
        navigationItem.setRightBarButtonItems([
            addIconBarButton
        ], animated: true)
        imageView.image = nil
        resetImagePicker()
    }

    @objc private func openImagePicker() {
        imagePicker = UIImagePickerController()
        imagePicker?.delegate = self
        imagePicker?.sourceType = .camera

        guard let picker = imagePicker else { return }

        present(picker, animated: true) {
            debugPrint("Image picker has been presented")
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
           removePicker(picker: picker)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }

        debugPrint(image)
        imageView.image = image
        removePicker(picker: picker)
        navigationItem.setRightBarButtonItems([
            removeIconBarButton
        ], animated: true)
    }

    private func removePicker(picker: UIImagePickerController) {
        picker.dismiss(animated: true) { [weak self] in
            self?.resetImagePicker()
        }
    }

    private func resetImagePicker() {
        imagePicker?.delegate = nil
        imagePicker = nil
    }
}

