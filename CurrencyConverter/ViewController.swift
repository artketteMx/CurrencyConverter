//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Arturo Cadena on 24/04/23.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var ratesButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.stopAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    

    @IBAction func tapGetRates(_ sender: Any) {
        clearStackView()
        activityIndicator.startAnimating()
        getRates()
        ratesButton.isEnabled = false
    }
}

extension ViewController {
    //For handling bussiness logic
    private func getRates() {
        
        ApiManager.getHNLRates {[weak self] (response, error) in
            guard let self = self else { return }
            self.activityIndicator.stopAnimating()
            self.ratesButton.isEnabled = true
            if let response = response {
                if response.success {
                    response.rates.sorted(by: {
                        $0.key < $1.key
                    }).forEach { (currency: String, rate: Double) in
                        self.stackView.addArrangedSubview(self.createCurrencyLabelEntry(currency: currency, rate: rate))
                    }
                    self.animateStackView()
                } else {
                    self.showError("Hubo un error al buscar las conversiones, intenta más tarde")
                }
            } else if let error = error {
                self.showError(error.localizedDescription)
            } else {
                self.showError("Hubo un error desconocido")
            }
        }
    }
}

extension ViewController {
    //For updating UI
    private func animateStackView() {
        self.stackView.alpha = 0
        UIView.animate(withDuration: 0.5) {
            self.stackView.alpha = 1
        }
    }
    
    private func createCurrencyLabelEntry(currency: String, rate: Double) -> UILabel {
        let label: UILabel = UILabel(frame: .zero)
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: label, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20).isActive = true
        label.textColor = .darkGray
        label.text = "\(currency) : \(rate)"
        return label
    }
    
    private func clearStackView() {
        animateStackView()
        stackView.arrangedSubviews.forEach { view in
            stackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
    
    private func showError(_ error: String) {
        let alert: UIAlertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { _ in
            alert.dismiss(animated: true)
        }))
        present(alert, animated: true)
    }
}
