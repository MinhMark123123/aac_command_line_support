/*
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'data_sources/#YOURFEATURE#_remote_data_source.dart';
import 'data_sources/#YOURFEATURE#_local_data_source.dart';
import 'data_sources/#YOURFEATURE#_retrofit.dart';
import 'repository/#YOURFEATURE#_repository.dart';

final #YOURFEATURECAMEL#RetrofitProvider = Provider<#YOURFEATURENAME#Retrofit>((ref) {
  return #YOURFEATURENAME#Retrofit(ref.watch(dioProvider));
});
final #YOURFEATURECAMEL#RemoteProvider = Provider<#YOURFEATURENAME#DataSource>((ref) {
  return #YOURFEATURENAME#RemoteDataSource(#YOURFEATURECAMEL#Retrofit: ref.watch(#YOURFEATURECAMEL#RetrofitProvider),);
});
final #YOURFEATURECAMEL#LocalProvider = Provider<#YOURFEATURENAME#DataSource>((ref) {
  return #YOURFEATURENAME#LocalDataSource();
});
final #YOURFEATURECAMEL#RepositoryProvider = Provider<#YOURFEATURENAME#Repository>((ref) {
  return #YOURFEATURENAME#Repository(
   #YOURFEATURECAMEL#RemoteSource: ref.watch(#YOURFEATURECAMEL#RemoteProvider),
   #YOURFEATURECAMEL#LocalSource: ref.watch(#YOURFEATURECAMEL#LocalProvider)
  );
});
*/
