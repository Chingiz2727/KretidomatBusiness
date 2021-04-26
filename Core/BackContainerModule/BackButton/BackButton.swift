import UIKit
import SnapKit

public final class BackButton: UIButton {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialLayout()
    }

    private func setupInitialLayout() {
        snp.makeConstraints { make in
            make.size.equalTo(36)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
