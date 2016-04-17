Pod::Spec.new do |s|
  s.name = 'GenericDataSources'
  s.version = '1.0.0'
  s.license = 'MIT'
  s.summary = 'A generic small composable components for data source implementation for UITableView and UICollectionView.'
  s.homepage = 'https://github.com/GenericDataSource/GenericDataSource'
  s.social_media_url = 'https://twitter.com/mohamede1945'
  s.authors = { "Mohamed Afifi" => "mohamede1945@gmail.com" }
  s.source = { :git => 'https://github.com/GenericDataSource/GenericDataSource.git', :tag => s.version }

  s.ios.deployment_target = '8.0'

  s.source_files = 'GenericDataSource/*.swift'
end