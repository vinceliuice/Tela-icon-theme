#
# spec file for package arc-icon-theme
#
# Copyright (c) 2019 SUSE LINUX GmbH, Nuernberg, Germany.
#
# All modifications and additions to the file contributed by third parties
# remain the property of their copyright owners, unless otherwise agreed
# upon. The license for this file, and modifications and additions to the
# file, is the same license as for the pristine package itself (unless the
# license for the pristine package is not an Open Source License, in which
# case the license is the MIT License). An "Open Source License" is a
# license that conforms to the Open Source Definition (Version 1.9)
# published by the Open Source Initiative.

# Please submit bugfixes or comments via https://bugs.opensuse.org/
#


Name:           tela-icon-theme
Version:        0
Release:        0
Summary:        Tela Icon Theme
License:        GPL-3.0-or-later
Url:            https://github.com/vinceliuice/Tela-icon-theme
Source:         https://github.com/vinceliuice/%{name}/archive/%{version}.tar.gz#/%{name}-%{version}.tar.gz
BuildRequires:  autoconf
BuildRequires:  automake
BuildRequires:  fdupes
BuildRequires:  hicolor-icon-theme
BuildRequires:  icon-naming-utils >= 0.8.7
Requires:       adwaita-icon-theme
Recommends:     moka-icon-theme
BuildArch:      noarch

%description
A flat, colorful icon theme

%prep
%autosetup

%install
TELA_DEST_DIR=%{buildroot}%{_datadir}/icons/ . install.sh
install -Dm644 README.md %{_defaultdocdir}/README.md
install -Dm644 COPYING %{_defaultdocdir}/COPYING
install -Dm644 AUTHORS %{_defaultdocdir}/CREDITS
%fdupes %{buildroot}%{_datadir}/icons/

# No need for %%icon_theme_cache_postun in %%postun since the theme won't exist anymore.

%files
%defattr(-,root,root)
%doc COPYING CREDITS README.md
%{_datadir}/icons/*/

%changelog
