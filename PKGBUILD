pkgname=omarchy-lazygit-theme-sync
pkgver=1.0.0
pkgrel=1
pkgdesc="Automatic lazygit theme synchronization for Omarchy"
arch=('any')
license=('MIT')
depends=('bash' 'lazygit')
source=("$pkgname-$pkgver.tar.gz")
md5sums=('SKIP')

package() {
  cd "$pkgname-$pkgver"

  # Install scripts
  install -Dm755 install.sh "$pkgdir/usr/share/$pkgname/install.sh"
  install -Dm755 uninstall.sh "$pkgdir/usr/share/$pkgname/uninstall.sh"
  install -Dm755 generate-themes.sh "$pkgdir/usr/share/$pkgname/generate-themes.sh"

  # Install lazygit scripts
  install -Dm755 scripts/lazygit-theme-apply.sh "$pkgdir/usr/share/$pkgname/scripts/lazygit-theme-apply.sh"
  install -Dm755 scripts/lazygit-theme-generate.sh "$pkgdir/usr/share/$pkgname/scripts/lazygit-theme-generate.sh"

  # Install wrapper
  install -Dm755 wrappers/lazygit "$pkgdir/usr/share/$pkgname/wrappers/lazygit"

  # Install hook
  install -Dm644 hooks-append/theme-set "$pkgdir/usr/share/$pkgname/hooks-append/theme-set"

  # Install themes
  install -d "$pkgdir/usr/share/$pkgname/themes"
  install -m644 themes/*.yml "$pkgdir/usr/share/$pkgname/themes/"

  # Install license
  install -Dm644 LICENSE "$pkgdir/usr/share/licenses/$pkgname/LICENSE"

  # Install README
  install -Dm644 README.md "$pkgdir/usr/share/doc/$pkgname/README.md"
}
